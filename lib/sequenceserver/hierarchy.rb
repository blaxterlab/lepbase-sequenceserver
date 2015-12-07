module SequenceServer
  # Module to contain methods for dealing with taxonomic hierarchy.
  module Hierarchy
  
    def initialize (root = 'Lepidoptera')
      @root = root;
    end
  
  	def parents
      {
        :default => 'Lepidoptera',
        :Agraulis => 'Butterflies',
  	    :Bicyclus => 'Butterflies',
  	    :Bombyx => 'Moths',
  	    :Chilo => 'Moths',
  	    :Danaus => 'Butterflies',
  	    :Eueides => 'Butterflies',
  	    :Heliconius => 'Butterflies',
  	    :Laparus => 'Butterflies',
  	    :Lerema => 'Butterflies',
  	    :Manduca => 'Moths',
  	    :Melitaea => 'Butterflies',
  	    :Neruda => 'Butterflies',
  	    :Papilio => 'Butterflies',
  	    :Pieris => 'Butterflies',
  	    :Plodia => 'Moths',
  	    :Plutella => 'Moths'
  	  }
    end
    
    
  end
end

