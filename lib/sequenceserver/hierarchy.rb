module SequenceServer
  # Module to contain methods for dealing with taxonomic hierarchy.
  class Hierarchy

  	def initialize (root = 'All')
    	@root = root
    end

  	def parents
      par = {
        'Lepidoptera' => 'All',
  	    'Nematoda' => 'All',
  	    'Bicyclus' => 'Lepidoptera',
  	    'Heliconius' => 'Lepidoptera',
        'Lumbricus' => 'Annelida',
        'Acanthocheilonema' => 'Nematoda',
        'Ascaris' => 'Nematoda',
        'Dictyocaulus' => 'Nematoda',
        'Onchocerca' => 'Nematoda',
        'Oscheius' => 'Nematoda',
        'Plectus' => 'Nematoda',
        'Setaria' => 'Nematoda'
  	  }
  	  par.default = @root
  	  return par
    end

    def nesting(name)
      arr = [name]
      until name == @root
        name = parents[name]
        arr.unshift name
      end
      return arr
    end

    def nested_list(databases,suffix = '')
      hash = {}
      databases.each do |database|
        title = database.title or database.name
        next unless title.split.last.match(suffix)
        title = title.sub ' - '+suffix, ''
        name = title.split.first.capitalize
        levels = nesting(name)
        parent = 'root'
        levels.each do |level|
          hash[parent] ||= {}
          if level == name
            hash[parent][title] ||= {}
            hash[parent][title]['db'] = database.id
            hash[parent][title]['type'] = database.type
          else
            hash[parent][level] ||= {}
            hash[parent][level]['type'] = database.type
            hash[parent][level]['internal'] = 1;
          end
          parent = level
        end
      end
      return hash
    end

    def ul(databases,suffix = '')
      hash = nested_list(databases,suffix)
      html = enlist(hash,'root',suffix)
      return html
    end

    def enlist(hash,parent,suffix)
      html = '<ul>'
      if hash[parent]
       hash[parent].each do |key,value|
         html += '<li class="'+suffix+'-node'
         if parent == 'root'
         	html += ' jstree-open"'
         else
         	html += '"'
         end
         if value['internal']
           html += ' data-type="'+value['type']+'">'+key
         else
           html += ' name="databases[]" value="'+value['db']+'" data-type="'+value['type']+'">'+key
         end
         if value['internal']
            html += enlist(hash,key,suffix)
          end
          html += '</li>'
        end
      end
      html += '</ul>'
      return html
    end

  end
end
