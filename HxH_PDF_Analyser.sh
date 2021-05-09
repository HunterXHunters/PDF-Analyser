#! /bin/bash

#HxH PDF Analyser
#Script to automate malicious PDF

echo "HxH PDF Analyser"
echo "Script to automate malicious PDF"
echo ""

#SETUP OPERATIONS

mkdir pdfid_results
mkdir pdf_parser_results
mkdir peepdf

pdfid=pdfid_results
pdfparser=pdf_parser_results
peepdf=peepdf

echo ""
echo ""
# PDFIND Plugin to look for specific characteristics within PDF for a quick view [Header, Objects, Keywords]
echo "pdfid is running, results pending"
pdfid.py $1 > $pdfid/pdfinf_results.txt
echo ""
echo "pdfid completed"

# PDF-PARSER to deep investigation 
echo ""
echo ""
echo "pdf-parser plugin with --search flag is running, results pending"
echo ""

# "pdf-parser plugin with --search flag to search for OpenAction"
pdf-parser.py --search openaction $1 > $pdfparser/pdfparser_search_OpenAction.txt

pdf-parser.py --search AA $1 > $pdfparser/pdfparser_search_OpenAction.txt
#
#
#
# "pdf-parser plugin with --search flag to search for launch"

pdf-parser.py --search launch $1 > $pdfparser/pdfparser_search_launch.txt
#
#
#
# "pdf-parser plugin with --search flag to search for JavaScript"

pdf-parser.py --search javascript $1 > $pdfparser/pdfparser_search_javascript.txt

pdf-parser.py --search js $1 > $pdfparser/pdfparser_search_js.txt
#
#
#
# "pdf-parser plugin with --search flag to search for names"

pdf-parser.py --search names $1 > $pdfparser/pdfparser_search_names.txt
#
#
#
# "pdf-parser plugin with --search flag to search for EmbeddedFile"

pdf-parser.py --search EmbeddedFile $1 > $pdfparser/pdfparser_search_EmbeddedFile.txt
#
#
#
# "pdf-parser plugin with --search flag to search for URI and SubmitForm"

pdf-parser.py --search URI $1 > $pdfparser/pdfparser_search_URI.txt

pdf-parser.py --search SubmitForm $1 > $pdfparser/pdfparser_search_SubmitForm.txt

echo ""
echo "PDF-PARSER plugins completed searching for TERMS"
echo ""

pdf-parser.py --search launch $1 > $pdfparser/pdfparser_search_launch.txt

echo ""
echo ""
#
#

##pdf-parser to map document with Yara

pdf-parser.py -y YaraRules/yara/rules/index.yar $1 > $pdfparser/Yara.txt

yara -w -msg YaraRules/yara/rules/index.yar $1 > $pdfparser/PlainYara.txt



#
#
#


##### Peepdf ########################

peepdf.py $1 > $peepdf/pdf_information.txt
