FROM postgres
ENV POSTGRES_PASSWORD=pumps POSTGRES_USER=pumps
EXPOSE 5432
COPY latest.dump /db.dump
RUN pg_restore --verbose --clean --no-acl --no-owner -h localhost -U pumps -d pumps db.dump

#to get the docker container running run the following commands in the root of the app:
#docker build
# docker run -it -p 5432:5432 pumps_db

#in case you wish to have a visula representation through pgadmin4 run the following command:
#docker run -p 80:80 -e "PGADMIN_DEFAULT_EMAIL=fahdyousri@gmail.com" -e "PGADMIN_DEFAULT_PASSWORD=P@ssw0rd" -d --network="host" dpage/pgadmin4
#don't forget to replace the email and password to your preference