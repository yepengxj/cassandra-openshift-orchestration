# cassandra的编排
在openshift上生成一个cassandra的集群。
注意：需要赋予读取api server的权限
`oc policy add-role-to-user view -z default`
##0x01 初始化
先初始化，生成种子pod
oc create -f cassandra-boot.yaml
创建一个pod 一个service
##0x02 创建用户
待初始化完成以后，登录cassandra
登录
`cqlsh -u cassandra -p cassandra ip port`
创建新的超级用户
`CREATE USER myusername WITH PASSWORD 'mypassword' SUPERUSER ;`
cqlsh退出以后，用新用户登陆
`cqlsh -u myusername -p mypassword ip port`
删除默认用户
`drop user cassandra;`
##0x03创建其他高可用pod 
oc create -f cassandra-ha.yaml
##0x04绑定的时候
创建一个其他用户名和密码的超级用户
`CREATE USER myusername WITH PASSWORD 'mypassword' SUPERUSER ;`

测试
`nodetool status`
##0x05解除绑定的时候
删除这个用户
`drop user cassandra;`

##0x06甚至：这个套餐时可以升级的，简单的把relicas设置一下就好了



