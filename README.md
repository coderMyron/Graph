# Graph
图表：邻接表、邻接矩阵、广度优先搜索、深度优先搜索、迪克斯特拉 (Dijkstra)算法
图是由顶点和顶点之间边组成的一种数据结构。  
## 加权图
在加权图中，每一条边都有一个权重，我们可以利用这个权重来计算出图中两个顶点的最小路径。

## 有向图
图的边除了可以有权重之外，还可以有方向，而且可以是双向或者是单向的。

## 无向图
我们可以把无向图看作是一个所有边都是双向的有向图。

## 邻接表
用一个字典 adjacencies 来存储从某个顶点发出的边，然后是实现 Graph 协议。

## 邻接矩阵
邻接矩阵用一个正方形的矩阵来表示一个图。矩阵由一个二维数组组成。matrix[1][2] 对应的值是在索引为 1 的顶点到索引为 2 的顶点的边的权重。  

## 性能分析
邻接表和邻接矩阵实现图的性能对比如下, V 代表顶点，E 代表边：
操作  |邻接表 | 邻接矩阵
----- | ----- | -----
存储空间 | O(V + E) | O(V^2)
添加顶点发| O(1)发| O(V^2)
添加边发| O(1) | O(1)
查找边和权重 | O(V) | O(1)

邻接表所需的存储空间小于邻接矩阵，邻接表可以直接存储顶点和边，而邻接矩阵需要用个二维数组来存储边，二维数组元素个数就等于顶点的个数，所以是O(V^2)。
邻接表添加顶点，直接存入字典即可，所以是 O(1)。邻接矩阵添加顶点，需要在二维数组添加多一行和一列，时间复杂度至少是 O(V)，如果矩阵由一个连续的内存区域存储，有可能是 O(V^2)。
邻接表添加边，直接在字典中key对应的数组添加元素；邻接矩阵添加边，直接更改二维数组的其中一个元素，都是 O(1)。
邻接表查找某条边和权重，需要找到从某个顶点出发的所有边，然后通过循环找到特定的边，所以最坏的情况下是 O(V)。邻接矩阵查找某条边和权重，能直接从二维数组中找到对应的元素，所以时间是 O(1)。
邻接表和邻接矩阵，我们如何选择？如果我们的图中边的数量不多，选择邻接表，因为邻接矩阵所需的内存比较大。如果我们的图有很多边，选择邻接矩阵比较好，因为他在查找边和权重上速度较快。

## 广度优先搜索(BFS breadthFirstSearch)、深度优先搜索(DFS depthFirstSearch)
广度优先搜索和深度优先搜索是在图的基础上来讨论的，它们都是图的顶点的遍历方式。 
### 广度优先搜索
广度优先搜索可以用来解决这些问题：1）生成最小生成树；2）寻找顶点之间所有可能的路径；3）寻找顶点之间的最短路径。  
我们把从一个起点开始的边的终点称为邻居，那么广度优先搜索的执行过程可以概括为：首先选择一个起点，然后遍历完这个起点的所有邻居之后再遍历这些邻居的邻居，以此类推。
我们使用**队列**来存储要遍历的顶点，队列先进先出的特性可以保证一个顶点的邻居在邻居的邻居之前遍历。
### 性能分析
在遍历过程中，每个顶点入队一次，时间复杂度为 O(V)，在遍历过程中，我们还遍历了所有的边，时间复杂度为 O(E)，所以总体的事件复杂度为 O(V + E)。  

### 深度优先搜索
深度优先搜索可以用来解决这些问题：1）拓扑排序；2）检测是有循环；3）寻找路径；4）在图中寻找连通的组件。  
深度优先搜索的执行过程可以概括为：从一个顶点开始，尽可能的往下搜寻，直到到达底部为止；然后在往回走，搜寻另外一个分支，直到遍历完整个图。
我们使用**栈**来存储要遍历的顶点，队列后进先出的特性可以让我们在一个分支走到底部时往回走。每次 push 一个顶点，就意味着往更深一层。

### 性能分析
在遍历过程中，每个顶点都会被遍历一次，时间复杂度为 O(V)，在遍历过程中，我们还遍历了所有的邻居，以确定是否还要继续往更深一层继续遍历，时间复杂度为 O(E)，所以总体的事件复杂度为 O(V + E)。空间复杂度为 O(V)，因为我们要存储图中的所有顶点。  

## 迪克斯特拉算法
Dijkstra算法，中文叫迪克斯特拉算法，在地图中寻找两个地点之间的最短或者最快路径非常有用。狄克斯特拉算法是一个贪婪算法，也就是在处理过程中每一步都选择最佳路径。  

在实现过程中，我们要用到**优先队列**，这里我们用最小优先队列，这样每次从队列中取出的元素都是目前总权重最小的顶点。用一个字典来记录每一步的数据，key 是顶点，value 是顶点类型或者是关联着通往这个顶点的边，循环取出队列当前最小权重的顶点，遍历从这个顶点出发的边，如果边的终点不在字典中，或者从当前顶点出发达到边的终点总权重小于之前的路径，更新路径，并把邻居加入到队列中。根据记录着每一步数据的字典，找到到达某个终点的最小路径，返回由边组成的有序数组。

### 性能分析
迪克斯特拉算法的时间复杂度，主要取决于优先队列中元素的移除和插入。  
优先队列中元素的移除和插总的时间是 O(log V)。在算法的实现中，我们还要遍历所有的顶点，时间为 O(E)。所以迪克斯特拉算法总的时间复杂度为 O(E log V)。  


## 示例
```
print("邻接表")
let graph = AdjacencyList<String>()

let wuHan = graph.createVertex(value: "武汉")
let shangHai = graph.createVertex(value: "上海")
let shenZhen = graph.createVertex(value: "深圳")
let beiJing = graph.createVertex(value: "北京")
let hongKong = graph.createVertex(value: "香港")
let newYork = graph.createVertex(value: "纽约")

graph.addEdge(.undirected, from: wuHan, to: shangHai, weight: 300)
graph.addEdge(.undirected, from: wuHan, to: shenZhen, weight: 500)
graph.addEdge(.undirected, from: shangHai, to: shenZhen, weight: 700)
graph.addEdge(.undirected, from: shangHai, to: beiJing, weight: 600)
graph.addEdge(.undirected, from: shenZhen, to: beiJing, weight: 1000)
graph.addEdge(.undirected, from: shenZhen, to: hongKong, weight: 200)
graph.addEdge(.undirected, from: beiJing, to: newYork, weight: 6000)
graph.addEdge(.undirected, from: hongKong, to: newYork, weight: 5000)

print(graph)

print("-------------")
print("邻接矩阵")

let graph2 = AdjacencyMatrix<String>()

let wuHan2 = graph2.createVertex(value: "武汉")
let shangHai2 = graph2.createVertex(value: "上海")
let shenZhen2 = graph2.createVertex(value: "深圳")
let beiJing2 = graph2.createVertex(value: "北京")

graph2.addDirectedEdge(from: wuHan2, to: shangHai2, weight: 300)
graph2.addDirectedEdge(from: wuHan2, to: shenZhen2, weight: 500)
graph2.addDirectedEdge(from: shangHai2, to: beiJing2, weight: 600)
graph2.addDirectedEdge(from: shenZhen2, to: shangHai2, weight: 700)
graph2.addUndirectedEdge(between: shenZhen2, and: beiJing2, weight: 1000)

print(graph2)

print("-------------")
print("广度优先搜索")

let vertices = graph.breadthFirstSearch(from: wuHan)
vertices.forEach { print($0) }

print("-------------")
print("深度优先搜索")

let vertices2 = graph.depthFirstSearch(from: wuHan)
vertices2.forEach { print($0) }

print("-------------")
print("迪克斯特拉 (Dijkstra)算法")

let graph3 = AdjacencyList<String>()

let a = graph3.createVertex(value: "A")
let b = graph3.createVertex(value: "B")
let c = graph3.createVertex(value: "C")
let d = graph3.createVertex(value: "D")
let e = graph3.createVertex(value: "E")
let f = graph3.createVertex(value: "F")
let g = graph3.createVertex(value: "G")
let h = graph3.createVertex(value: "H")

graph3.addDirectedEdge(from: a, to: b, weight: 1)
graph3.addDirectedEdge(from: a, to: d, weight: 9)
graph3.addDirectedEdge(from: a, to: c, weight: 2)
graph3.addDirectedEdge(from: b, to: d, weight: 2)
graph3.addDirectedEdge(from: c, to: d, weight: 8)
graph3.addDirectedEdge(from: c, to: f, weight: 5)
graph3.addDirectedEdge(from: d, to: g, weight: 9)
graph3.addDirectedEdge(from: d, to: e, weight: 7)
graph3.addDirectedEdge(from: e, to: d, weight: 5)
graph3.addUndirectedEdge(between: e, and: f, weight: 4)
graph3.addDirectedEdge(from: e, to: h, weight: 3)

let dijkstra = Dijkstra(graph: graph3)
let pathsFromA = dijkstra.paths(from: a)
let path = dijkstra.shortestPath(to: e, with: pathsFromA)
for edge in path {
    print("\(edge.source) -- \(edge.weight ?? 0) -- > \(edge.destination)")
}
```

## 打印
```
邻接表
0: 武汉 --> [ 1: 上海, 2: 深圳 ]
1: 上海 --> [ 0: 武汉, 2: 深圳, 3: 北京 ]
2: 深圳 --> [ 0: 武汉, 1: 上海, 3: 北京, 4: 香港 ]
3: 北京 --> [ 1: 上海, 2: 深圳, 5: 纽约 ]
4: 香港 --> [ 2: 深圳, 5: 纽约 ]
5: 纽约 --> [ 3: 北京, 4: 香港 ]

-------------
邻接矩阵
0: 武汉
1: 上海
2: 深圳
3: 北京

ø		300.0	500.0	ø		
ø		ø		ø		600.0	
ø		700.0	ø		1000.0	
ø		ø		1000.0	ø		
-------------
广度优先搜索
0: 武汉
1: 上海
2: 深圳
3: 北京
4: 香港
5: 纽约
-------------
深度优先搜索
0: 武汉
1: 上海
2: 深圳
3: 北京
5: 纽约
4: 香港
-------------
迪克斯特拉 (Dijkstra)算法
0: A -- 1.0 -- > 1: B
1: B -- 2.0 -- > 3: D
3: D -- 7.0 -- > 4: E
```




