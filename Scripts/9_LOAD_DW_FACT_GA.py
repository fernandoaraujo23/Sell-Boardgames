import pandas as pd
import pyodbc
import numpy as np

server = 'localhost'
database = 'SELL_DW'
username = 'sa'
password = '@1q2w3e4r'
driver= '{ODBC Driver 13 for SQL Server}'
cnxn0 = pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password)
cnxn1 = pyodbc.connect('DRIVER='+driver+';SERVER='+server+';PORT=1433;DATABASE='+database+';UID='+username+';PWD='+ password)
print('Started') 

df = pd.read_csv('c:/POTV/Data/Google Analytics.csv',quotechar='"')
df.rename(columns = {'Date':'GA_DATE'}, inplace = True)
df.rename(columns = {'Entrances':'GA_ENTRANCES'}, inplace = True)
df.rename(columns = {'Landing Page':'GA_LANDING_PAGE'}, inplace = True)
df.rename(columns = {'Sessions':'GA_SESSIONS'}, inplace = True)
df.rename(columns = {'Bounces':'GA_BOUNCES'}, inplace = True)
df.rename(columns = {'clicks':'GA_CLICKS'}, inplace = True)
df.rename(columns = {'impressions':'GA_IMPRESSIONS'}, inplace = True)
df.rename(columns = {'Time On page (seconds)':'GA_TIME_ON_PAGE'}, inplace = True)
df.rename(columns = {'Pageviews':'GA_PAGEVIEWS'}, inplace = True)
df.rename(columns = {'Exits':'GA_EXITS'}, inplace = True)
df = df.fillna(0)

df['GA_LANDING_PAGE_T'] = df['GA_LANDING_PAGE'].str.split(' ').str[0]
df['GA_LANDING_PAGE_T2'] = df['GA_LANDING_PAGE_T'].str.split('https').str[0]
df['GA_URL_CLEAR'] = np.where(df['GA_LANDING_PAGE_T2'].str.find('?')>0, df['GA_LANDING_PAGE_T2'].str.split('?').str[0],
              np.where(df['GA_LANDING_PAGE_T2'].str.find('#') > 0, df['GA_LANDING_PAGE_T2'].str.split('#').str[0],
              df['GA_LANDING_PAGE_T2']))

df['GA_URL_CLEAR_T'] = df['GA_URL_CLEAR'].str.replace('www.sellboardgames.com/', '', regex=True)
df['GA_CATEGORY'] = df['GA_URL_CLEAR_T'].str.split('/').str[0]


df['GA_VALUE'] = df['GA_URL_CLEAR_T'].str.split('/').str[-1]

cursor0 = cnxn0.cursor()
for index,row in df.iterrows():
    cursor0.execute("INSERT INTO dbo.DW_FACT_GA(GA_DATE,GA_ENTRANCES,GA_LANDING_PAGE,GA_SESSIONS,GA_BOUNCES,GA_CLICKS,GA_IMPRESSIONS,GA_TIME_ON_PAGE,GA_PAGEVIEWS,GA_EXITS,GA_URL_CLEAR,GA_CATEGORY,GA_VALUE) values (?,?,?,?,?,?,?,?,?,?,?,?,?)", row['GA_DATE'],row['GA_ENTRANCES'],row['GA_LANDING_PAGE'],row['GA_SESSIONS'],row['GA_BOUNCES'],row['GA_CLICKS'],row['GA_IMPRESSIONS'],row['GA_TIME_ON_PAGE'],row['GA_PAGEVIEWS'],row['GA_EXITS'],row['GA_URL_CLEAR'],row['GA_CATEGORY'],row['GA_VALUE']) 
    cnxn0.commit()
cursor0.close()

cursor1 = cnxn1.cursor()
    cursor1.execute("EXEC LOAD_GA_AGGREGATE") 
    cnxn1.commit()
cursor1.close()
print('Finished') 