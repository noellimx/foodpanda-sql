


# NOTE

unsafe database and connection.

### Requirements

MacOS
SQL within Docker Image
Azure Data Studio

#### Image

Ensure sql image is pulled, else ```sudo docker pull mcr.microsoft.com/mssql/server:2019-latest ```


#### Run sql container

Running with default params -> ```sudo docker run --name SQLServer -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=Password-123'  -p 1433:1433 mcr.microsoft.com/mssql/server:2019-latest```

#### Azure Data Studio

SQL session and visualizer. (Alternatives may be sourced)




