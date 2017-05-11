import System.IO
import Data.Maybe
import Data.Equivalence.Monad
import Data.Graph as G
import Data.List as L
import Data.Map as M
import Control.Monad (filterM)
import Data.Ord (comparing)

-- make the list into a list of tuple of a tuple and an integer
triplets f [] = f
triplets f (x:y:z:xs) = triplets (f ++ [((x, y), z)]) xs

run = runEquivM (const ()) (const $ const ())

-- kruskal algorithm: sort the list for costs/weights and filter with a union-find
kruskal weight graph = run $
    filterM go (sortBy (comparing weight) theEdges)
     where
       theEdges = G.edges graph
       go (u,v) = do
         eq <- equivalent u v
         if eq then return False else
          equate u v >> return True


-- lookup costs of edge in Map
fromL xs = fromJust . flip M.lookup (M.fromList xs) -- function to value (cost) when providing key (edge)

-- n is the number of testcases
krus f n = do
    if n > 0
        then do
            let numEdges = (head . tail) f
            -- k = numVertices, numEdges, and then edges in format of: vert1, vert2, costs
            -- k equals the number of integers related to our testcase (needed to take away at the end)
            let k = 2+3*numEdges
            -- make triplets out of the edges
            let edges = triplets [] $ drop 2 . take k $ f
            -- testWeights is the lookup function for
            let testWeights = fromL edges
            -- build a graph out of the edges (which we have to convert back from the triplets)
            let testGraph = G.buildG (1, numEdges - 1) $ L.foldr ((:) . fst) [] edges
            -- sum over the costs and print it
            print (sum $ L.map testWeights $ kruskal testWeights testGraph)
            -- drop all edges from this testcase from the list
            krus (drop k f) (n - 1)
        else return ()

main = do
    file <- readFile "public.txt"
    let contents = L.map read $ words file :: [Int] -- parse file into list of integers
    krus (tail contents) (head contents) -- tail is list of edeges, head is number of testcases
    return ()
