#!/bin/bash
rsync -azP --delete --exclude='.git/' --exclude='.DS_Store' ./ ubuntu@34.207.234.211:/var/www/html/rodrigo
