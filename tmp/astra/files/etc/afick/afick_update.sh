#!/bin/bash
#Запускаем пересчет эталонов КЦ
afick -u
# Очищаем файл заблокированных групп
cp /dev/null /etc/afick/blocked_groups.list
# Очищаем log-файл afick-check.sh
cp /dev/null /var/log/afick/afick.log
# запускаем отправку данных на сервер Zabbix для снятия события
sh /etc/afick/send_to_zabbix.sh
exit 0
