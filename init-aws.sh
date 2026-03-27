#!/bin/bash

echo "Iniciando AWS LocalStack..."

awslocal s3 mb s3://langsfuse-bucket

echo "Bucket creado correctamente."