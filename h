
[1mFrom:[0m /usr/local/rvm/gems/ruby-2.2.1/gems/activerecord-4.2.1/lib/active_record/associations/collection_association.rb @ line 30 ActiveRecord::Associations::CollectionAssociation#reader:

    [1;34m29[0m: [32mdef[0m [1;34mreader[0m(force_reload = [1;36mfalse[0m)
 => [1;34m30[0m:   [32mif[0m force_reload
    [1;34m31[0m:     klass.uncached { reload }
    [1;34m32[0m:   [32melsif[0m stale_target?
    [1;34m33[0m:     reload
    [1;34m34[0m:   [32mend[0m
    [1;34m35[0m: 
    [1;34m36[0m:   [32mif[0m owner.new_record?
    [1;34m37[0m:     [1;34m# Cache the proxy separately before the owner has an id[0m
    [1;34m38[0m:     [1;34m# or else a post-save proxy will still lack the id[0m
    [1;34m39[0m:     @new_record_proxy ||= [1;34;4mCollectionProxy[0m.create(klass, [1;36mself[0m)
    [1;34m40[0m:   [32melse[0m
    [1;34m41[0m:     @proxy ||= [1;34;4mCollectionProxy[0m.create(klass, [1;36mself[0m)
    [1;34m42[0m:   [32mend[0m
    [1;34m43[0m: [32mend[0m

