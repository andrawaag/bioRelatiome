awk '{print "PREFIX wp: <http://vocabularies.wikipathways.org/wp#>";}'
cut -f1,2,9,14 intact.txt |
awk '{
	
	interact1 = $1;
	interact2=$2;
	pmids=$3; 
	interactionIds = $4;
	split(interact1, source, ":"); 
	split(interact2, target, ":"); 
	split(pmids, pubmed, "|");
	split(pubmed[1], pmid, ":");
	split(interactionIds, interactionId, ":"); 
	sub(/kb/, "", source[1]);
	sub(/kb/, "", target[1]);
	sub(/\|mint|\|imex/, "", interactionId[2]); 
	

	sourceIdentifierOrg = "<http://identifiers.org/"source[1]"/"source[2]">";
	targetIdentifierOrg = "<http://identifiers.org/"target[1]"/"target[2]">";
	interactionIdentifiersOrg = "<http://identifiers.org/"interactionId[1]"/"interactionId[2]">";
	if (pubmed[1] ~ "pubmed") {
	   pubmedIdentifiersorg = "<http://identifiers.org/pubmed/"pmid[2];
	}
	print interactionIdentifiersOrg " a wp:relation .";
	print interactionIdentifiersOrg " wp:source " sourceIdentifierOrg  " .";
	print interactionIdentifiersOrg " wp:target " targetIdentifierOrg  " .";
	print interactionIdentifiersOrg " dcterms:references " pubmedIdentifiersorg " .";
	
   }' >>intact.ttl
   
