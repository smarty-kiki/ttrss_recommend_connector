#!/bin/bash

ROOT_DIR="$(cd "$(dirname $0)" && pwd)"/../../..

ln -fs $ROOT_DIR/project/config/production/nginx/ttrss_recommend_connector.conf /etc/nginx/sites-enabled/ttrss_recommend_connector
/usr/sbin/service nginx reload

/bin/bash $ROOT_DIR/project/tool/dep_build.sh link
/usr/bin/php $ROOT_DIR/public/cli.php migrate:install
/usr/bin/php $ROOT_DIR/public/cli.php migrate

ln -fs $ROOT_DIR/project/config/production/supervisor/ttrss_recommend_connector_queue_worker.conf /etc/supervisor/conf.d/ttrss_recommend_connector_queue_worker.conf
/usr/bin/supervisorctl update
/usr/bin/supervisorctl restart ttrss_recommend_connector_queue_worker:*
