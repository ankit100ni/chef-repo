# client_run

## This cookbook has the latest chef-client versin when created

- To implement the audit cookbook following attributes needs to be added

```
default['audit']['reporter'] = 'chef-server-automate'
default['audit']['fetcher'] = 'chef-server'


default['audit']['profiles']['InSpecProfile'] = {
 compliance: 'admin/httpd',
}
```
