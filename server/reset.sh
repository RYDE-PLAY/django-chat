#!/bin/bash

# 删除数据库
find . -path "*.sqlite3" -delete

# 删除除了__init__.py以外的migrations文件（注意路径内不应存在虚拟环境）
find ./apps -path "*/migrations/*.py" -not -name "__init__.py" -delete
find ./apps -path "*/migrations/*.pyc" -delete

# 重建数据库
python manage.py makemigrations
python manage.py migrate

# 初始化superuser
export DJANGO_SUPERUSER_USERNAME=admin
export DJANGO_SUPERUSER_PASSWORD=admin
export DJANGO_SUPERUSER_EMAIL=admin@admin.com
python manage.py createsuperuser --noinput --username $DJANGO_SUPERUSER_USERNAME --email $DJANGO_SUPERUSER_EMAIL
