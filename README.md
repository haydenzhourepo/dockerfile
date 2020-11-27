## dockerfile for dev or production


## hadoop (has issues)
This component has some issues as below:

First set up docker containers
```
cd hadoop
docker-compose up -d

dc exec hadoop bash

# format namenode in container
hdfs namenode -format

# start services,  commonds below will be move to entriyponit.sh as soon as  issues fixed
hadoop-daemon.sh start namenode
hadoop-daemon.sh start datanode

```

Then test using java 
```
public FileSystem getFileSystem() throws Exception {
Configuration config = new Configuration();
return FileSystem.get(new URI("hdfs://hadoop:8020"), config);
}

@Test
public void CopyFromLocalFile() throws Exception {
FileSystem hdfs = getFileSystem();

Path src = new Path("src/main/resources/testdata/index/input/d.txt");
Path dest = new Path("/");
hdfs.copyFromLocalFile(src, dest);

FileStatus[] fileStatuses = hdfs.listStatus(new Path("/"));
for (FileStatus fileStatus : fileStatuses) {
System.out.println(fileStatus.getPath());
}
}

```

Issues:
```
 ch : java.nio.channels.SocketChannel[connection-pending remote=/172.29.0.2:50010]
	at org.apache.hadoop.net.NetUtils.connect(NetUtils.java:534)
	at org.apache.hadoop.hdfs.DataStreamer.createSocketForPipeline(DataStreamer.java:259)
	at org.apache.hadoop.hdfs.DataStreamer.createBlockOutputStream(DataStreamer.java:1699)
	at org.apache.hadoop.hdfs.DataStreamer.nextBlockOutputStream(DataStreamer.java:1655)
	at org.apache.hadoop.hdfs.DataStreamer.run(DataStreamer.java:710)


org.apache.hadoop.ipc.RemoteException(java.io.IOException): File /d.txt could only be replicated to 0 nodes instead of minReplication (=1).  There are 1 datanode(s) running and 1 node(s) are excluded in this operation.
```

Search:
https://hadoop.apache.org/docs/r2.8.0/hadoop-project-dist/hadoop-hdfs/HdfsMultihoming.html#Ensuring_HDFS_Daemons_Bind_All_Interfaces

Mostly of those are that `dfs.client.use.datanode.hostname` should be set to true,  and i have set it in `./conf/hdfs-site.xml`, but this is not work for me.




## kafka
```
cd kafka-dev 
docker-compose up -d
```
then you can visit kafka cluster by localhost:9092 and visit cluster web ui by localhost:9000




