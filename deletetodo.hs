import System.IO
import System.Directory
import Data.List

main = do
  --todo.txt を読み込みcontentsに束縛
  contents <- readFile "todo.txt"
  --文字列を行ごとに分割
  let todoTasks = lines contents
  --0から始まるリスト([0..]) と 文字列 を受け取り、新しい文字列を返す関数 でzipする 
      numberedTasks = zipWith (\n line -> show n ++ " - " ++ line) [0..] todoTasks
  --文字列表示
  putStrLn "These are your TO-DO items:"
  --行ごとに表示
  mapM_ putStrLn numberedTasks
  --文字列表示
  putStrLn "Which one do you want to delete?"
  --削除する行番号を受け取り束縛
  numberString <- getLine
  let number = read numberString
  --todoTasks !! number で、要素を取り出し、
  --delete で指定したリストの要素を削除する
      newTodoItems = unlines $ delete (todoTasks !! number) todoTasks
  --一時ファイルを作成する
  (tempName, tempHandle) <- openTempFile "." "temp"
  --一時ファイルにnewTodoItemsを書き込む
  hPutStr tempHandle newTodoItems
  --一時ファイルを閉じる
  hClose tempHandle
  --元のファイルを削除する
  removeFile "todo.txt"
  --リネームして新しいtodo.txtを作る
  renameFile tempName "todo.txt"
