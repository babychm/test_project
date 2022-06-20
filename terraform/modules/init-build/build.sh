#!/bin/sh
aws ecr get-login-password --region "$region" | docker login --username AWS --password-stdin "$registry_id".dkr.ecr."$region".amazonaws.com
git clone "$github_repo"
cd  ./test_project/app
sed -r "s|image:.*server.*|image: "$ecr_url":"$app_image_1"-"$app_tag"|g" docker-compose.yml > changed.yml && mv changed.yml docker-compose.yml
sed -r "s|image:.*client.*|image: "$ecr_url":"$app_image_2"-"$app_tag"|g" docker-compose.yml > changed.yml && mv changed.yml docker-compose.yml
docker-compose build
docker-compose push
cd ../..
rm -rf test_project
