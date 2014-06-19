pwd
echo "PREFIX wp: <http://vocabularies.wikipathways.org/wp#>">>intact.ttl
echo "PREFIX dcterms: <http://purl.org/dc/terms/>"  >>intact.ttl
echo "PREFIX sio: <http://semanticscience.org/resource/>" >>intact.ttl
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
	if (interactionId[2] ~/\|/) {
	    split(interactionId[2], tempinteractionId, "|");
        interactionId[2] = tempinteractionId[1]
	    }
	sub(/\|mint|\|imex/, "", interactionId[2]); 
	if (source[2] ~ /"/) source[2]=source[2]":"source[3];
	if (target[2] ~ /"/) target[2]=target[2]":"target[3];
		gsub(/"/, "", source[2]);
		gsub(/"/, "", target[2]);
	sourceIdentifierOrg = "<http://identifiers.org/"source[1]"/"source[2]">";
	targetIdentifierOrg = "<http://identifiers.org/"target[1]"/"target[2]">";
	interactionIdentifiersOrg = "<http://identifiers.org/"interactionId[1]"/"interactionId[2]">";
	if (pubmed[1] ~ "pubmed") {
	   pubmedIdentifiersorg = "<http://identifiers.org/pubmed/"pmid[2]">";
	}
	print interactionIdentifiersOrg " a wp:relation .";
	print sourceIdentifierOrg " sio:SIO_000001 "targetIdentifierOrg " ."
	print interactionIdentifiersOrg " wp:source " sourceIdentifierOrg  " .";
	print interactionIdentifiersOrg " wp:target " targetIdentifierOrg  " .";
	print interactionIdentifiersOrg " dcterms:references " pubmedIdentifiersorg " .";
	
   }' >>intact.ttl
   
