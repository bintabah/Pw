FROM mariadb:10.11

# Optimisation mémoire pour tenir dans 256MB
RUN echo "[mysqld]\ninnodb_buffer_pool_size=64M\ninnodb_log_buffer_size=8M\nkey_buffer_size=8M\nmax_connections=20\ntmp_table_size=8M\nmax_heap_table_size=8M" \
    > /etc/mysql/conf.d/memory.cnf

COPY init.sql /docker-entrypoint-initdb.d/init.sql
