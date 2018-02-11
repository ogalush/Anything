#coding: utf8
import re  # regexp

##- print
print ("はろー")
print ("はろー"+"わーるど")
print('------------------')

#-- array
sales = [50, 100, 80, 45]
sales.sort()
print(sales)
print('------------------')

#-- if
score = 40
if score > 60:
  print("OK")
elif score > 40:
  print("MIDDLE")
else:
  print("MINIMUM")
print('------------------')

#-- for
##print range(100)
for i in range(100):
  print i
print('------------------')

#-- regexp
regexp = re.compile("^\d+$")
if regexp.match("12345"):
 print "match"
else:
 print "NOT Match"

if re.match("^\d+$","hoge"):
 print "match2"
else:
 print "not match2"
print('------------------')

#-- subroutine

##- subroutine
def exec_hoge(str):
 return str + ":add exec_hoge"
str2 = exec_hoge("str1")
print str2
