library(DBI)
library(RPostgreSQL)
library(RPostgres)
library(data.table)

path_data  <- "data"

# de .Renviron ziet er alsvolgt uit:

#Server = "ip-adres"
#Database = "datahub"  
#UID = "databuffet_ggd_...."
#hash = "password"
#Port = 5000

# aanpassen naar eigen locatie
path_to_Renviron_file <- "C:/Users/l.vanbrabant/Documents/.Renviron"
readRenviron(path_to_Renviron_file) 

con <- DBI::dbConnect(RPostgres::Postgres(),
                      host     = Sys.getenv("Server"),
                      dbname   = Sys.getenv("Database"),
                      user     = Sys.getenv("UID"),
                      password = Sys.getenv("hash"),
                      port     = Sys.getenv("Port")
)

# get vaccinatie data
vac <- DBI::dbGetQuery(con, "SELECT nm_batchnummer, dt_vaccinatie, vaccinatiestatus,
                             ggd_regio, nr_vaccinatieronde, bsn, postcode, huisnummer
                             FROM vaccinatie")

fwrite(vac, file = file.path(path_data, paste0(Sys.Date(), "_vaccinaties.csv")))


