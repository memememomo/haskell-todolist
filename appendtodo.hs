import System.IO

main = do
  -- 標準入力から受け取る
  todoItem <- getLine
  -- getLine は開業を取り除いた文字列を返すので、
  -- 最後に改行を追加する
  appendFile "todo.txt" (todoItem ++ "\n")

