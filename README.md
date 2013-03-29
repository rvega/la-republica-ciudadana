La República Ciudadana
======================

Una aplicación de preguntas y respuestas para ciudadanos colombianos. Escrita en ruby y rails.


Cómo configurar el ambiente de desarrollo en Ubuntu 12.04
---------------------------------------------------------

### 1. Instale la versión 1.9.3 de ruby

    sudo apt-get install zlib1g-dev openssl libopenssl-ruby1.9.1 libssl-dev libruby1.9.1 libreadline-dev git-core
    git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.profile
    echo 'eval "$(rbenv init -)"' >> ~/.profile
    exec $SHELL -l
    git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
    rbenv install 1.9.3-p385
    rbenv rehash
    rbenv global 1.9.3-p385

### 2. Baje el código de La República Ciudadana y otras librerías necesarias

    git clone https://github.com/rvega/la-republica-ciudadana.git
    cd la-republica-ciudadana/server
    sudo apt-get install libxml2 libxml2-dev libxslt1-dev libpq-dev libsqlite3-dev build-essential libv8-dev
    gem install bundle
    bundle install
    rbenv rehash

### 3. Inicialize la base de datos

    rake db:setup

Cómo contribuir código
----------------------

Si usted no es un contribuidor de La República Ciudadana, por favor haga un fork de nuestro repositorio, crée un branch nuevo y envíenos un pull request cuando haya terminado.

Si usted es un contribuidor, crée un branch nuevo y cuando haya terminado, haga merge al branch development.

Gracias!
