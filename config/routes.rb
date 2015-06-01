Konacha::Engine.routes.draw do
  root :to    => 'specs#parent'
  get '*path' => 'specs#parent', :format => false
end
