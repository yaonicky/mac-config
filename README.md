# Mac LNMP 集成环境快速配置

1. 创建配置文件夹

   ```bash
   mkdir ~/Web/config && cd ~/Web/config
   ```

2. 克隆项目录

   ```bash
   git clone git@github.com:yaonicky/mac-config.git .
   ```

3. 设定配置选项

   ```bash
   USER_HOME="/Users/nicky"
   DOMAIN_SELF="dev"
   source $USER_HOME/Web/config/bash/init-function.bash
   ### Set Paths
   # ------------------------------------------------------------
   export PATH="$USER_HOME/Web/config/bin:$PATH"
   # ------------------------------------------------------------
   ```

4. 创建新项目

   ```bash
   vhost-nginx-add
   ```

   
