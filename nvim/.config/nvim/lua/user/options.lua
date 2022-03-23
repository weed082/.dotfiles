local options = {
  clipboard = "unnamedplus",              
  cmdheight = 1,                         
  completeopt = { "menuone", "noselect" }, 
  conceallevel = 0,                       
  fileencoding = "utf-8",                  
  ignorecase = true,                      
  mouse = "a",                            
  pumheight = 10,                          
  showmode = false,
  smartcase = true,                        
  smartindent = true,                      
  splitbelow = true,                       
  splitright = true,                       
  swapfile = false,                        
  termguicolors = true,                    
  undofile = true,                         
  updatetime = 300,                        
  writebackup = false,                     
  expandtab = true,                        
  shiftwidth = 2,                          
  tabstop = 2,                             
  cursorline = true,                       
  number = true,                          
  relativenumber = true,                  
  numberwidth = 2,                         
  signcolumn = "yes",                      
  wrap = false,                            
  scrolloff = 8,                           
  sidescrolloff = 8,
  guifont = "monospace:h17",              
}

for k, v in pairs(options) do
  vim.opt[k] = v
end
