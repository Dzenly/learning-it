https://www.youtube.com/watch?v=FvlwBWvI-Zg

Workers - where work performed.

Managers - monitoring, orchestration, .

Managers choose leader with RAFT algorythm.

Leader decides on which worker to run your container.

tcp ports 2377, 7946
udp ports 4789, 7946

--advertise-addr - the manager address to manage cluster.

docker swarm join --token <my-token> masterIP:2377.

managers have different token.

`docker node info` - list of nodes, workers, managers, leader.













https://www.youtube.com/watch?v=BrOUx5AMOBE

Если есть swarm, то compose м.б. и не нужен.

