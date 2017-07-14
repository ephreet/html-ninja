#!/usr/bin/env python
import sys, getopt, os
import magic

def tobits(s):
    result = []
    for c in s:
        bits = bin(ord(c))[2:]
        bits = '00000000'[len(bits):] + bits
        result.extend([int(b) for b in bits])
    return result

def frombits(bits):
    chars = []
    for b in range(len(bits) / 8):
        byte = bits[b*8:(b+1)*8]
        chars.append(chr(int(''.join([str(bit) for bit in byte]), 2)))
    return ''.join(chars)


def checkfile (src):
        print ("Computing space available in file " + src + " ...")
        i = 0
        f = open(src,"r")
        c = f.read()
        f.close()
        av_space = c.count(" ")
        print (av_space)
        print ("Computing space required to encrypt file " + src + " ...")
        payload_bits = tobits(c)
        payload_string = "".join([str(x) for x in payload_bits] )
        req_space = payload_string.count("")
        print (req_space)


def decrypt ( src, dst):
	print ("Reading contents of file " + src + " ...")
	prevchar="nil"
	bits=""
	f = open(src,"r")
	while True:
	   c = f.read(1)
	   if not c:
	      break
	   if prevchar == " ":
	    if c == " ":
	     bits = bits + "1"
	     c="nil"
	    else:
	     bits = bits + "0"
	     c="nil"
	   prevchar=c
	print ("Converting and saving to " + dst + " ...")
	number = int(bits, 2)
	outfile = open(dst,"wb")
	outfile.write(frombits(bits))
	outfile.close()
	m = magic.open(magic.MAGIC_MIME)
	m.load()
	print ("File " + dst + " was written! Contents: " + m.file(dst))


def encrypt ( src, content, dst ):
	print ("Reading contents of file " + src + " ...")
	i = 0
	f = open(src,"r")
	c = f.read()
	f.close()
	av_space = c.count(" ")
	print ("Space available:")
	print (av_space)
	f = open(content,"r")
	p = f.read()
	f.close()
	payload_bits = tobits(p)
	payload_string = "".join([str(x) for x in payload_bits] )
	req_space = payload_string.count("")
	print ("Space required:")
	print (req_space)

	if req_space > av_space:
		print "Not enough white spaces available!"
		sys.exit()

	# remove double spaces already present in source file
	print("Cleaning up document " + dst + " ...")
	newfile=""
	f = open(src,"r")
	tmp = f.read()
	f.close()
	tmp = tmp.replace('  ','').replace('\n','').replace('\r','')
	f = open("white.tmp","w")
	f.write(tmp)
	f.close()
	f = open("white.tmp","r")
	i = 0
	prevchar = ""
	print("Generating final file " + dst + " ...")
	while True:
	  c = f.read(1)
	  if not c:
		break
	  if c == " " and (i < req_space-1) and not prevchar == " ":
	    if payload_bits[i] == 1:
	     newfile = newfile + "  "
	    elif payload_bits[i] == 0:
	     newfile = newfile + " "
	    i = i+1
	  elif not (c == "\n" or c == "\r"):
	    newfile = newfile + c
	  prevchar = c
	f.close()
	f = open(dst,"w")
	f.write(newfile)
	f.close()
	os.remove("white.tmp")
	print("File " + dst + " created!")


def usage():
   print "HTML NINJA is a steganograpy tool to encrypt files in white spaces of html documents: the final result is a oneline HTML that, when parsed by browsers, will show only single spaces"
   print "This will work only if the source page will have enough spaces to contain the data to be hidden!"
   print "You can also use it on any text container, but the result will be unformatted text with a lot of suspicious spaces..."
   print ''
   print "USAGE EXAMPLES: "
   print "html-ninja.py -e source content outfile -> will encode the payload file 'content' into file 'source' and output the result as 'outfile'"
   print "html-ninja.py -d source outfile -> will try to decrypt white spaces in 'source' file into 'outfile'"
   print "html-ninja.py --check filename -> will check 'filename' for available spaces and spaces needed to embed the file"

def banner():
   print (" _   _____          _   _   _ _        _    _    \n| |_|_   _| __ ___ | | | \ | (_)_ __  (_)  / \   \n| '_ \| || '_ ` _ \| | |  \| | | '_ \ | | / _ \  \n| | | | || | | | | | | | |\  | | | | || |/ ___ \ \n|_| |_|_||_| |_| |_|_| |_| \_|_|_| |_|/ /_/   \_\ ")
   print '                                                                                                                                                                                                                                                                                            by ephreet'
   print ''

def main(argv):
   banner()
   if len(sys.argv) == 1: sys.argv[1:] = ["-h"]
   action = sys.argv[1]
   if action == "-e":
	if len(sys.argv) == 5:
		srcfile = sys.argv[2]
		content = sys.argv[3]
		outfile = sys.argv[4]
		encrypt (srcfile, content, outfile)
	else:
		usage()
   elif action == "-d":
	if len(sys.argv) == 4:
		srcfile = sys.argv[2]
		outfile = sys.argv[3]
		decrypt (srcfile, outfile)
	else:
		usage()
   elif action == "--check":
	if len(sys.argv) == 3:
		checkfile(sys.argv[2])
   else:
	usage()

if __name__ == "__main__":
   main(sys.argv[1:])

