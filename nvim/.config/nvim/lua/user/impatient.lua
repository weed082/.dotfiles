local status_ok, impatient = pcall(require, "impatient")
if not status_ok then
  print("impatient bad status")
  return
end

impatient.enable_profile()
