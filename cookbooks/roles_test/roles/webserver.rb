name 'web_servers'
description 'This role contains nodes, which act as web servers'
run_list 'recipe[default]'
# default_attributes 'ntp' => {
#    'ntpdate' => {
#       'disable' => true,
#    },
# }
