# HTML-NINJA by ephreet

HTML NINJA is a steganograpy tool to encrypt files in white spaces of html documents: the final result is a oneline HTML that, when parsed by browsers, will show only single spaces
This will work only if the source page will have enough spaces to contain the data to be hidden!
You can also use it on any text container, but the result will be unformatted text with a lot of suspicious spaces...


## USAGE EXAMPLES:
```
html-ninja.py -e source content outfile -> will encode the payload file 'content' into file 'source' and output the result as 'outfile'
html-ninja.py -d source outfile -> will try to decrypt white spaces in 'source' file into 'outfile'
html-ninja.py --check filename -> will check 'filename' for available spaces and spaces needed to embed the file
html-ninja.py -d http://localhost/html-ninja.html stdout -> will get http url and output to stdout
html-ninja.py -d http://localhost/html-ninja.html exec -> will get http url and execute the hex payload (payload must have a '|' terminator)
html-ninja.py -ez / -dz ... -> adds zlib compression to both encryption and decryption
html-ninja.py -eb / -db ... -> adds bz2 compression to both encryption and decryption
```

## html-ninja.js

This is a very basic function to read hidden data directly from browser, there are a lot of ways you can use this...just use your imagination!


## html-ninja.html

This is a PoC to show how it's possible to embed self decrypting data inside html pages. This needs a proper web server to run (not file:///...)
