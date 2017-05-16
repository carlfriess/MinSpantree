import System.IO
import Data.Maybe
import qualified Data.IntMap.Strict as IM
import Data.List as L
import Data.Map as M
import Data.Ord (comparing)

data Edge = MyEdge
 { edgeFrom :: Int
 , edgeTo :: Int
 , edgeCost :: Int
 } deriving (Show, Eq)

instance Ord Edge where
    compare = comparing edgeCost

makeEdgeList f [] = f
makeEdgeList f (x:y:z:xs) = makeEdgeList (f ++ [MyEdge x y z]) xs

-- create Keys that represent values and that are their parents
makeSets n = IM.fromList [(key, val) | key <- [1..n], val <- [1..n], key == val]
-- replace the key in the set with a new value
replace key new sets = IM.adjust (\ a ->  new) key sets
-- replace the Parent
replaceParent u v set = replace (getParent u set) (getParent v set) set

getParent v sets
    | parent == v = v
    | otherwise = getParent parent sets
    where
        parent = fromJust $ IM.lookup v sets

diffParent u v sets = getParent u sets /= getParent v sets

kruskal' [] sets costs = costs
kruskal' edges sets costs
    | diffParent u v sets  = kruskal' (tail edges) (replaceParent u v sets) (costs + c)
    | otherwise            = kruskal' (tail edges) sets costs
    where
        u = edgeFrom (head edges)
        v = edgeTo   (head edges)
        c = edgeCost (head edges)

kruskal f n
    | n > 0 = do
        print $ kruskal' edges sets 0
        kruskal (drop k f) (n - 1)
    | otherwise = print "Done"
    where
        numVert  = head f
        numEdges = (head . tail) f
        k = 2+3*numEdges
        edges = sort $ makeEdgeList [] $ drop 2 . take k $ f
        sets = makeSets numVert

main = do
    file <- readFile "public.txt"
    let contents = L.map read $ words file :: [Int] -- parse file into list of integers
    kruskal (tail contents) (head contents) -- tail is list of edeges, head is number of testcases
    return ()
