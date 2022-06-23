local status_ok, comment = pcall(require, "Comment")
if not status_ok then
  print("comment bad status")
  return
end

comment.setup()
