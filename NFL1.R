library(readr)
library("readxl")
library(dplyr)
library(rvest)
library("writexl")

#Import CSVs

#QB stats data set 2000-2019
df_NFL <- read_csv("data/NFL_QB_Stats.csv")

#Last two seasons
df_2021 <- read_csv("data/2021.csv")
df_2020 <- read_csv("data/2020.csv")

#Fix spaces in column headers
# names(df_NFL)<-str_replace_all(names(df_NFL), c(" " = "_"))



#Add season coloumn 
df_2021 <- df_2021 %>% mutate(Season = 2021)
df_2020 <- df_2020 %>% mutate(Season = 2020)

#Put last two seasons together 
df_NFL_latest <- rbind(df_2021, df_2020)      

#Remove columns before bindng data 
df_NFL$Won <- NULL
df_NFL$Lost <- NULL
df_NFL$Tied <- NULL
df_NFL_latest$Pos <- NULL
df_NFL_latest$Rk <- NULL
df_NFL_latest$QBrec <- NULL
df_NFL_latest$Yds...12 <- NULL
df_NFL_latest$Yds...26 <- NULL
df_NFL$Yds <- NULL
df_NFL$'Yds 1' <- NULL
df_NFL$Record <- NULL


#Rerrange columns
df_NFL_latest <- df_NFL_latest%>% relocate(Season, .before = Player)
df_NFL_latest <- df_NFL_latest%>% relocate(QBR, .after = last_col())

#Rename column so dfs match
df_NFL_latest <- df_NFL_latest%>% 
  rename(
    Team = Tm,
  )

#Bind dataframes
df_NFL_22_Seasons <- rbind(df_NFL, df_NFL_latest)


#Export csv
write_xlsx(df_NFL_22_Seasons, "22_NFL_SEASONS.xlsx")