cd /tmp
# uncomment below to get the hmdb metabolites and subsequently unzip it
# /usr/local/bin/wget http://www.hmdb.ca/downloads/hmdb_metabolites.zip
# unzip hmdb_metabolites.zip
cd /tmp/hmdb_metabolites

# PREFIXES
echo "PREFIX dcterms: <http://purl.org/dc/terms/>" >>/tmp/hmdbMetaboliteProteinInteration.ttl
echo "PREFIX rdfs: <http://www.w3.org/2000/01/rdf-schema#>" >>/tmp/hmdbMetaboliteProteinInteration.ttl

FILES=/tmp/hmdb_metabolites/*.xml
for file in $FILES
  do
   /opt/local/bin/xmlstarlet sel -t -m //protein -v "concat('<http://identifiers.org/hmdb/',../../../metabolite/accession, '> dcterms:relation <http://identifiers.org/uniprot/',./uniprot_id,'> .')" -n \
	   -v "concat('<http://identifiers.org/uniprot/', ./uniprot_id,'> dcterms:identifier \"',./uniprot_id,'\" .')" -n \
	   -v "concat('<http://identifiers.org/uniprot/', ./uniprot_id,'> rdfs:label \"', ./name, '\"@en .')" -n \
	   -v "concat('<http://identifiers.org/uniprot/', ./uniprot_id,'> rdfs:label \"', ./gene_name, '\"@en .')" -n  \
	   -v "concat('<http://identifiers.org/hmdb/', ../../../metabolite/accession, '> dcterms:identifier \"', ../../../metabolite/accession,'\" .')" -n \
	   -v "concat('<http://identifiers.org/hmdb/', ../../../metabolite/accession, '> rdfs:label \"', ../../../metabolite/name,'\"@en .')" -n $file |sed "s/&lt;/</g" |sed "s/&gt;/>/g" >>/tmp/hmdbMetaboliteProteinInteration.ttl

  done