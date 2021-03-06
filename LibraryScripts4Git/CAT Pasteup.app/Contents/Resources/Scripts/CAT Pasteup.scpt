FasdUAS 1.101.10   ��   ��    k             l     ��  ��    #   Created by James Lake 1996.     � 	 	 :     C r e a t e d   b y   J a m e s   L a k e   1 9 9 6 .   
  
 l     ��  ��    > 8  Copyright (c) 2003 beyond vision. All rights reserved.     �   p     C o p y r i g h t   ( c )   2 0 0 3   b e y o n d   v i s i o n .   A l l   r i g h t s   r e s e r v e d .      l     ��������  ��  ��        l     ��  ��    1 +Progress bar needs redone --DONE 11/28/2011     �   V P r o g r e s s   b a r   n e e d s   r e d o n e   - - D O N E   1 1 / 2 8 / 2 0 1 1      l     ��  ��    0 *Attach dialogs in Finder to the app window     �   T A t t a c h   d i a l o g s   i n   F i n d e r   t o   t h e   a p p   w i n d o w      l     ��  ��    O IChange window options dependent upon other changed options --DONE 8/16/07     �   � C h a n g e   w i n d o w   o p t i o n s   d e p e n d e n t   u p o n   o t h e r   c h a n g e d   o p t i o n s   - - D O N E   8 / 1 6 / 0 7     !   l     �� " #��   " K EPopulate Show Code field and options when a catalog is currently open    # � $ $ � P o p u l a t e   S h o w   C o d e   f i e l d   a n d   o p t i o n s   w h e n   a   c a t a l o g   i s   c u r r e n t l y   o p e n !  % & % l     ��������  ��  ��   &  ' ( ' l     ��������  ��  ��   (  ) * ) p       + + �� ,�� 0 currentuser CurrentUser , �� -�� 0 showcode ShowCode - �� .�� 0 
shownumber 
ShowNumber . �� /�� 0 cattype CatType / �� 0�� 0 showtype ShowType 0 �� 1�� 0 docsize DocSize 1 �� 2�� 0 
layouttype 
LayoutType 2 �� 3��  0 getjudgereport GetJudgeReport 3 �� 4�� "0 checkringstimes CheckRingsTimes 4 �� 5�� $0 deleteringstimes DeleteRingsTimes 5 �� 6�� "0 removekwnjudges RemoveKWNJudges 6 �� 7�� 0 
boxresults 
BoxResults 7 �� 8�� 0 localshowpath LocalShowPath 8 �� 9��  0 servershowpath ServerShowPath 9 �� :�� "0 judgereportpath JudgeReportPath : �� ;�� 0 
useheaders 
UseHeaders ; �� <�� 0 usecurrentdoc UseCurrentDoc < �� =�� 0 catpath CATPath = �� >�� 0 
judgeerror 
JudgeError > �� ?�� 0 	judgelist 	JudgeList ? �� @�� 0 
agentstext 
AgentsText @ �� A��  0 exhibitorstext ExhibitorsText A �� B�� 0 shownamelist ShowNameList B �� C�� 0 showdatelist ShowDateList C �� D�� 0 needexbindex NeedExbIndex D �� E�� 0 hasexbindex HasExbIndex E �� F�� 0 groupfilelist GroupFileList F �� G��  0 groupfilecount GroupFileCount G �� H�� 0 iconpath iconPath H ������ 0 docname DocName��   *  I J I l     ��������  ��  ��   J  K L K l     ��������  ��  ��   L  M N M l      �� O P��   O��)script OrderGroups --This defines a subroutine
 
 --Duplicate this variable for reordering
 copy GroupFileList to FileListOrdered
 
 --Check to see if reordering is necessary
 set ReorderGroups to false
 repeat with GroupCodeCounter from 1 to GroupFileCount
 if GroupCodeCounter = 1 then
 set GroupCode to (text 4 through 7 of item GroupCodeCounter of FileListOrdered)
 else
 if text 4 through 7 of item GroupCodeCounter of FileListOrdered � GroupCode then
 set ReorderGroups to true
 exit repeat
 end if
 end if
 end repeat
 
 if ReorderGroups is true then
 repeat with GrpFileCounter from 1 to (count of items of GroupFileList)
 activate --Let the user choose the files in catalog order
 set FileToCheck to (choose from list GroupFileList with prompt "Choose file " & GrpFileCounter)
 --If cancel button is clicked then quit script and notify user
 if FileToCheck is false then
 with timeout of 3600 seconds
 tell me to quit (activate)
 display dialog "The CAT Pasteup script was canceled." buttons {"Cancel"} default button 1 with icon stop
 tell me to quit
 end timeout
 end if
 --Repeat once for each item left in list
 repeat with GrpItemCounter from 1 to count of items of GroupFileList
 --Check to see if this item contains FileToCheck
 if item GrpItemCounter of GroupFileList contains FileToCheck then
 --Put this item in its correct place
 set item GrpFileCounter of FileListOrdered to item GrpItemCounter of GroupFileList
 --Remove the item from the list after it is chosen
 set GroupFileList to suppress item GrpItemCounter from GroupFileList
 exit repeat
 end if
 end repeat
 end repeat
 --Set the final info into the correct variable
 copy FileListOrdered to GroupFileList
 
 end if
 
 end script    P � Q Q^ ) s c r i p t   O r d e r G r o u p s   - - T h i s   d e f i n e s   a   s u b r o u t i n e 
   
   - - D u p l i c a t e   t h i s   v a r i a b l e   f o r   r e o r d e r i n g 
   c o p y   G r o u p F i l e L i s t   t o   F i l e L i s t O r d e r e d 
   
   - - C h e c k   t o   s e e   i f   r e o r d e r i n g   i s   n e c e s s a r y 
   s e t   R e o r d e r G r o u p s   t o   f a l s e 
   r e p e a t   w i t h   G r o u p C o d e C o u n t e r   f r o m   1   t o   G r o u p F i l e C o u n t 
   i f   G r o u p C o d e C o u n t e r   =   1   t h e n 
   s e t   G r o u p C o d e   t o   ( t e x t   4   t h r o u g h   7   o f   i t e m   G r o u p C o d e C o u n t e r   o f   F i l e L i s t O r d e r e d ) 
   e l s e 
   i f   t e x t   4   t h r o u g h   7   o f   i t e m   G r o u p C o d e C o u n t e r   o f   F i l e L i s t O r d e r e d  "`   G r o u p C o d e   t h e n 
   s e t   R e o r d e r G r o u p s   t o   t r u e 
   e x i t   r e p e a t 
   e n d   i f 
   e n d   i f 
   e n d   r e p e a t 
   
   i f   R e o r d e r G r o u p s   i s   t r u e   t h e n 
   r e p e a t   w i t h   G r p F i l e C o u n t e r   f r o m   1   t o   ( c o u n t   o f   i t e m s   o f   G r o u p F i l e L i s t ) 
   a c t i v a t e   - - L e t   t h e   u s e r   c h o o s e   t h e   f i l e s   i n   c a t a l o g   o r d e r 
   s e t   F i l e T o C h e c k   t o   ( c h o o s e   f r o m   l i s t   G r o u p F i l e L i s t   w i t h   p r o m p t   " C h o o s e   f i l e   "   &   G r p F i l e C o u n t e r ) 
   - - I f   c a n c e l   b u t t o n   i s   c l i c k e d   t h e n   q u i t   s c r i p t   a n d   n o t i f y   u s e r 
   i f   F i l e T o C h e c k   i s   f a l s e   t h e n 
   w i t h   t i m e o u t   o f   3 6 0 0   s e c o n d s 
   t e l l   m e   t o   q u i t   ( a c t i v a t e ) 
   d i s p l a y   d i a l o g   " T h e   C A T   P a s t e u p   s c r i p t   w a s   c a n c e l e d . "   b u t t o n s   { " C a n c e l " }   d e f a u l t   b u t t o n   1   w i t h   i c o n   s t o p 
   t e l l   m e   t o   q u i t 
   e n d   t i m e o u t 
   e n d   i f 
   - - R e p e a t   o n c e   f o r   e a c h   i t e m   l e f t   i n   l i s t 
   r e p e a t   w i t h   G r p I t e m C o u n t e r   f r o m   1   t o   c o u n t   o f   i t e m s   o f   G r o u p F i l e L i s t 
   - - C h e c k   t o   s e e   i f   t h i s   i t e m   c o n t a i n s   F i l e T o C h e c k 
   i f   i t e m   G r p I t e m C o u n t e r   o f   G r o u p F i l e L i s t   c o n t a i n s   F i l e T o C h e c k   t h e n 
   - - P u t   t h i s   i t e m   i n   i t s   c o r r e c t   p l a c e 
   s e t   i t e m   G r p F i l e C o u n t e r   o f   F i l e L i s t O r d e r e d   t o   i t e m   G r p I t e m C o u n t e r   o f   G r o u p F i l e L i s t 
   - - R e m o v e   t h e   i t e m   f r o m   t h e   l i s t   a f t e r   i t   i s   c h o s e n 
   s e t   G r o u p F i l e L i s t   t o   s u p p r e s s   i t e m   G r p I t e m C o u n t e r   f r o m   G r o u p F i l e L i s t 
   e x i t   r e p e a t 
   e n d   i f 
   e n d   r e p e a t 
   e n d   r e p e a t 
   - - S e t   t h e   f i n a l   i n f o   i n t o   t h e   c o r r e c t   v a r i a b l e 
   c o p y   F i l e L i s t O r d e r e d   t o   G r o u p F i l e L i s t 
   
   e n d   i f 
   
   e n d   s c r i p t N  R S R l     ��������  ��  ��   S  T U T l     ��������  ��  ��   U  V W V h     �� X�� 0 makeheaders MakeHeaders X l      Y Z [ Y k       \ \  ] ^ ] l     ��������  ��  ��   ^  _ ` _ l     �� a b��   a % Repeat for each Group Text File    b � c c > R e p e a t   f o r   e a c h   G r o u p   T e x t   F i l e `  d e d l   Q f���� f Y    Q g�� h i�� g k   L j j  k l k l   ��������  ��  ��   l  m n m Q    � o p q o l   < r s t r k    < u u  v w v r     x y x l    z���� z c     { | { l    }���� } b     ~  ~ o    ���� 0 catpath CATPath  n     � � � 4    �� �
�� 
cobj � o    ���� 0 groupcounter GroupCounter � o    ���� 0 groupfilelist GroupFileList��  ��   | m    ��
�� 
ctxt��  ��   y o      ���� 0 	groupfile 	GroupFile w  � � � I   (�� � �
�� .rdwropenshor       file � 4    "�� �
�� 
file � o     !���� 0 	groupfile 	GroupFile � �� ���
�� 
perm � m   # $��
�� boovfals��   �  � � � r   ) 3 � � � I  ) 1�� ���
�� .rdwrread****        **** � 4   ) -�� �
�� 
file � o   + ,���� 0 	groupfile 	GroupFile��   � o      ���� 0 	grouptext 	GroupText �  ��� � I  4 <�� ���
�� .rdwrclosnull���     **** � 4   4 8�� �
�� 
file � o   6 7���� 0 	groupfile 	GroupFile��  ��   s 2 ,Get the information from the Group Text File    t � � � X G e t   t h e   i n f o r m a t i o n   f r o m   t h e   G r o u p   T e x t   F i l e p R      ������
�� .ascrerr ****      � ****��  ��   q l  D � � � � � k   D � � �  � � � I  D L�� ���
�� .rdwrclosnull���     **** � 4   D H�� �
�� 
file � o   F G���� 0 	groupfile 	GroupFile��   �  ��� � t   M � � � � k   O � � �  � � � O  O ] � � � I  S \�� ���
�� .aevtquitnull���    obj  � l  S X ����� � I  S X������
�� .miscactvnull��� ��� null��  ��  ��  ��  ��   �  f   O P �  � � � I  ^ y�� � �
�� .panSdlognull���    obj  � m   ^ _ � � � � � � S o m e t h i n g   b a d   h a p p e n e d   w h e n   I   w a s   r e a d i n g   t h e   G r o u p   f i l e s   f o r   h e a d e r s . � �� � �
�� 
btns � J   b g � �  ��� � m   b e � � � � �  C a n c e l��   � �� � �
�� 
dflt � m   j k����  � �� ���
�� 
disp � I  n s������
�� .coVSstoTnull���    obj ��  ��  ��   �  ��� � O  z � � � � I  ~ �������
�� .aevtquitnull���    obj ��  ��   �  f   z {��   � m   M N������   � ? 9If something bad happens then quit script and notify user    � � � � r I f   s o m e t h i n g   b a d   h a p p e n s   t h e n   q u i t   s c r i p t   a n d   n o t i f y   u s e r n  � � � l  � ���~�}�  �~  �}   �  � � � Z   � � � ��| � � F   � � � � � =  � � � � � c   � � � � � n   � � � � � 4   � ��{ �
�{ 
cha  � m   � ��z�z�� � n   � � � � � 4   � ��y �
�y 
cpar � m   � ��x�x  � o   � ��w�w 0 	grouptext 	GroupText � m   � ��v
�v 
ctxt � m   � � � � � � �  ) � =  � � � � � c   � � � � � n   � � � � � 4   � ��u �
�u 
cha  � m   � ��t�t�� � n   � � � � � 4   � ��s �
�s 
cpar � m   � ��r�r  � o   � ��q�q 0 	grouptext 	GroupText � m   � ��p
�p 
ctxt � m   � � � � � � �  ( � r   � � � � � n   � � � � � 7 � ��o � �
�o 
ctxt � m   � ��n�n  � m   � ��m�m�� � n   � � � � � 4   � ��l �
�l 
cpar � m   � ��k�k  � o   � ��j�j 0 	grouptext 	GroupText � o      �i�i 0 testname TestName�|   � l  � � � � � � r   � � � � � n   � � � � � 7 � ��h � �
�h 
ctxt � m   � ��g�g  � m   � ��f�f�� � n   � � � � � 4   � ��e �
�e 
cpar � m   � ��d�d  � o   � ��c�c 0 	grouptext 	GroupText � o      �b�b 0 testname TestName � / )Get the Show Name for the Group Text File    � � � � R G e t   t h e   S h o w   N a m e   f o r   t h e   G r o u p   T e x t   F i l e �  � � � l  � ��a�`�_�a  �`  �_   �  � � � l  � ��^ � ��^   � / )Get the Show Date for the Group Text File    � � � � R G e t   t h e   S h o w   D a t e   f o r   t h e   G r o u p   T e x t   F i l e �  � � � r   � � � � � n   � � � � � 7 � ��] � �
�] 
ctxt � m   � ��\�\  � m   � ��[�[�� � n   � � � � � 4   � ��Z 
�Z 
cpar  m   � ��Y�Y  � o   � ��X�X 0 	grouptext 	GroupText � o      �W�W 0 testdate TestDate �  l  � ��V�U�T�V  �U  �T    l  � ��S�S   6 0Shorten the Names & Dates only on multiple shows    � ` S h o r t e n   t h e   N a m e s   &   D a t e s   o n l y   o n   m u l t i p l e   s h o w s 	 Z   ��
�R�Q
 ?   �  l  � ��P�O I  � ��N�M
�N .corecnte****       **** n   � � 2  � ��L
�L 
cobj o   � ��K�K 0 groupfilelist GroupFileList�M  �P  �O   m   � ��J�J  k  �  l �I�H�G�I  �H  �G    l �F�F   % Remove the Inc. from Show Names    � > R e m o v e   t h e   I n c .   f r o m   S h o w   N a m e s  Z  d�E D    o  �D�D 0 testname TestName  m  !! �""  ,   I n c . r   #$# I �C%&�C 0 
switchtext 
switchText% o  �B�B 0 testname TestName& �A'(
�A 
from' m  )) �**  ,   I n c .( �@+�?
�@ 
to  + m  ,, �--  �?  $ o      �>�> 0 testname TestName ./. D  #(010 o  #$�=�= 0 testname TestName1 m  $'22 �33 
   I n c ./ 454 r  +@676 I +>�<89�< 0 
switchtext 
switchText8 o  +,�;�; 0 testname TestName9 �::;
�: 
from: m  /2<< �== 
   I n c .; �9>�8
�9 
to  > m  58?? �@@  �8  7 o      �7�7 0 testname TestName5 ABA D  CHCDC o  CD�6�6 0 testname TestNameD m  DGEE �FF    I n cB G�5G r  K`HIH I K^�4JK�4 0 
switchtext 
switchTextJ o  KL�3�3 0 testname TestNameK �2LM
�2 
fromL m  ORNN �OO    I n cM �1P�0
�1 
to  P m  UXQQ �RR  �0  I o      �/�/ 0 testname TestName�5  �E   STS l ee�.�-�,�.  �-  �,  T UVU l ee�+WX�+  W  Change Kennel Club to KC   X �YY 0 C h a n g e   K e n n e l   C l u b   t o   K CV Z[Z Z e�\]�*�)\ E  ej^_^ o  ef�(�( 0 testname TestName_ m  fi`` �aa  K e n n e l   C l u b] r  m�bcb I m��'de�' 0 
switchtext 
switchTextd o  mn�&�& 0 testname TestNamee �%fg
�% 
fromf m  qthh �ii  K e n n e l   C l u bg �$j�#
�$ 
to  j m  wzkk �ll  K C�#  c o      �"�" 0 testname TestName�*  �)  [ mnm l ���!� ��!  �   �  n opo l ���qr�  q ! Shorten the name of the day   r �ss 6 S h o r t e n   t h e   n a m e   o f   t h e   d a yp tut Z  �hvwx�v E  ��yzy o  ���� 0 testdate TestDatez m  ��{{ �||  F r i d a yw r  ��}~} I ����� 0 
switchtext 
switchText o  ���� 0 testdate TestDate� ���
� 
from� m  ���� ���  F r i d a y� ���
� 
to  � m  ���� ���  F R I�  ~ o      �� 0 testdate TestDatex ��� E  ����� o  ���� 0 testdate TestDate� m  ���� ���  S a t u r d a y� ��� r  ����� I ������ 0 
switchtext 
switchText� o  ���� 0 testdate TestDate� ���
� 
from� m  ���� ���  S a t u r d a y� ���
� 
to  � m  ���� ���  S A T�  � o      �� 0 testdate TestDate� ��� E  ����� o  ���� 0 testdate TestDate� m  ���� ���  S u n d a y� ��� r  ����� I ������ 0 
switchtext 
switchText� o  ���� 0 testdate TestDate� ���
� 
from� m  ���� ���  S u n d a y� �
��	
�
 
to  � m  ���� ���  S U N�	  � o      �� 0 testdate TestDate� ��� E  ����� o  ���� 0 testdate TestDate� m  ���� ���  M o n d a y� ��� r  ���� I ����� 0 
switchtext 
switchText� o  ���� 0 testdate TestDate� ���
� 
from� m  ���� ���  M o n d a y� ���
� 
to  � m  ���� ���  M O N�  � o      �� 0 testdate TestDate� ��� E  ��� o  � �  0 testdate TestDate� m  �� ���  T u e s d a y� ��� r  $��� I "������ 0 
switchtext 
switchText� o  ���� 0 testdate TestDate� ����
�� 
from� m  �� ���  T u e s d a y� �����
�� 
to  � m  �� ���  T U E��  � o      ���� 0 testdate TestDate� ��� E  ',��� o  '(���� 0 testdate TestDate� m  (+�� ���  W e d n e s d a y� ��� r  /D��� I /B������ 0 
switchtext 
switchText� o  /0���� 0 testdate TestDate� ����
�� 
from� m  36�� ���  W e d n e s d a y� �����
�� 
to  � m  9<�� ���  W E D��  � o      ���� 0 testdate TestDate� ��� E  GL��� o  GH���� 0 testdate TestDate� m  HK�� ���  T h u r s d a y� ���� r  Od��� I Ob������ 0 
switchtext 
switchText� o  OP���� 0 testdate TestDate� ����
�� 
from� m  SV�� ���  T h u r s d a y� �����
�� 
to  � m  Y\�� ���  T H R��  � o      ���� 0 testdate TestDate��  �  u ��� l ii��������  ��  ��  � ��� l ii������  � # Shorten the name of the month   � ��� : S h o r t e n   t h e   n a m e   o f   t h e   m o n t h�    Z  i��� E  in o  ij���� 0 testdate TestDate m  jm �  J a n u a r y r  q�	
	 I q����� 0 
switchtext 
switchText o  qr���� 0 testdate TestDate ��
�� 
from m  ux �  J a n u a r y ����
�� 
to   m  {~ �  J A N��  
 o      ���� 0 testdate TestDate  E  �� o  ������ 0 testdate TestDate m  �� �  F e b r u a r y  r  �� I ������ 0 
switchtext 
switchText o  ������ 0 testdate TestDate �� !
�� 
from  m  ��"" �##  F e b r u a r y! ��$��
�� 
to  $ m  ��%% �&&  F E B��   o      ���� 0 testdate TestDate '(' E  ��)*) o  ������ 0 testdate TestDate* m  ��++ �,, 
 M a r c h( -.- r  ��/0/ I ����12�� 0 
switchtext 
switchText1 o  ������ 0 testdate TestDate2 ��34
�� 
from3 m  ��55 �66 
 M a r c h4 ��7��
�� 
to  7 m  ��88 �99  M A R��  0 o      ���� 0 testdate TestDate. :;: E  ��<=< o  ������ 0 testdate TestDate= m  ��>> �?? 
 A p r i l; @A@ r  ��BCB I ����DE�� 0 
switchtext 
switchTextD o  ������ 0 testdate TestDateE ��FG
�� 
fromF m  ��HH �II 
 A p r i lG ��J��
�� 
to  J m  ��KK �LL  A P R��  C o      ���� 0 testdate TestDateA MNM E  ��OPO o  ������ 0 testdate TestDateP m  ��QQ �RR  M a yN STS r  �UVU I ���WX�� 0 
switchtext 
switchTextW o  ������ 0 testdate TestDateX ��YZ
�� 
fromY m  ��[[ �\\  M a yZ ��]��
�� 
to  ] m  ��^^ �__  M A Y��  V o      ���� 0 testdate TestDateT `a` E  	bcb o  	
���� 0 testdate TestDatec m  
dd �ee  J u n ea fgf r  &hih I $��jk�� 0 
switchtext 
switchTextj o  ���� 0 testdate TestDatek ��lm
�� 
froml m  nn �oo  J u n em ��p��
�� 
to  p m  qq �rr  J U N��  i o      ���� 0 testdate TestDateg sts E  ).uvu o  )*���� 0 testdate TestDatev m  *-ww �xx  J u l yt yzy r  1F{|{ I 1D��}~�� 0 
switchtext 
switchText} o  12���� 0 testdate TestDate~ ���
�� 
from m  58�� ���  J u l y� �����
�� 
to  � m  ;>�� ���  J U L��  | o      ���� 0 testdate TestDatez ��� E  IN��� o  IJ���� 0 testdate TestDate� m  JM�� ���  A u g u s t� ��� r  Qf��� I Qd������ 0 
switchtext 
switchText� o  QR���� 0 testdate TestDate� ����
�� 
from� m  UX�� ���  A u g u s t� �����
�� 
to  � m  [^�� ���  A U G��  � o      ���� 0 testdate TestDate� ��� E  in��� o  ij���� 0 testdate TestDate� m  jm�� ���  S e p t e m b e r� ��� r  q���� I q������� 0 
switchtext 
switchText� o  qr���� 0 testdate TestDate� ����
�� 
from� m  ux�� ���  S e p t e m b e r� �����
�� 
to  � m  {~�� ���  S E P��  � o      ���� 0 testdate TestDate� ��� E  ����� o  ������ 0 testdate TestDate� m  ���� ���  O c t o b e r� ��� r  ����� I �������� 0 
switchtext 
switchText� o  ������ 0 testdate TestDate� ����
�� 
from� m  ���� ���  O c t o b e r� �����
�� 
to  � m  ���� ���  O C T��  � o      ���� 0 testdate TestDate� ��� E  ����� o  ������ 0 testdate TestDate� m  ���� ���  N o v e m b e r� ��� r  ����� I �������� 0 
switchtext 
switchText� o  ������ 0 testdate TestDate� ����
�� 
from� m  ���� ���  N o v e m b e r� �����
�� 
to  � m  ���� ���  N O V��  � o      ���� 0 testdate TestDate� ��� E  ����� o  ������ 0 testdate TestDate� m  ���� ���  D e c e m b e r� ���� r  ����� I �������� 0 
switchtext 
switchText� o  ������ 0 testdate TestDate� ����
�� 
from� m  ���� ���  D e c e m b e r� �����
�� 
to  � m  ���� ���  D E C��  � o      ���� 0 testdate TestDate��  ��   ���� l ����������  ��  ��  ��  �R  �Q  	 ��� l ����������  ��  ��  � ��� l ��������  � ; 5Put a bullet between multiple (and unique) Show Names   � ��� j P u t   a   b u l l e t   b e t w e e n   m u l t i p l e   ( a n d   u n i q u e )   S h o w   N a m e s� ��� Z  �������� H  ���� E  ����� o  ������ 0 shownamelist ShowNameList� o  ������ 0 testname TestName� Z  ������� ?  ����� o  ������ 0 groupcounter GroupCounter� m  ������ � r   ��� b   	��� b   ��� o   ���� 0 shownamelist ShowNameList� m  �� ���    "  � o  ���� 0 testname TestName� o      �� 0 shownamelist ShowNameList��  � l    r   b   o  �~�~ 0 shownamelist ShowNameList o  �}�} 0 testname TestName o      �|�| 0 shownamelist ShowNameList ( "Put all the Show Names on one line    � D P u t   a l l   t h e   S h o w   N a m e s   o n   o n e   l i n e��  ��  � 	 l �{�z�y�{  �z  �y  	 

 l �x�x   ; 5Put a bullet between multiple (and unique) Show Dates    � j P u t   a   b u l l e t   b e t w e e n   m u l t i p l e   ( a n d   u n i q u e )   S h o w   D a t e s  Z  J�w�v H  $ E  # o  !�u�u 0 showdatelist ShowDateList o  !"�t�t 0 testdate TestDate Z  'F�s ?  '* o  '(�r�r 0 groupcounter GroupCounter m  ()�q�q  r  -: b  -6 b  -4  o  -0�p�p 0 showdatelist ShowDateList  m  03!! �""    "   o  45�o�o 0 testdate TestDate o      �n�n 0 showdatelist ShowDateList�s   l =F#$%# r  =F&'& b  =B()( o  =@�m�m 0 showdatelist ShowDateList) o  @A�l�l 0 testdate TestDate' o      �k�k 0 showdatelist ShowDateList$ ( "Put all the Show Dates on one line   % �** D P u t   a l l   t h e   S h o w   D a t e s   o n   o n e   l i n e�w  �v   +�j+ l KK�i�h�g�i  �h  �g  �j  �� 0 groupcounter GroupCounter h m    �f�f  i l   ,�e�d, I   �c-�b
�c .corecnte****       ****- n    ./. 2   �a
�a 
cobj/ o    �`�` 0 groupfilelist GroupFileList�b  �e  �d  ��  ��  ��   e 010 l     �_�^�]�_  �^  �]  1 232 l R�4�\�[4 O  R�565 k  X�77 898 l XX�Z:;�Z  : 4 .Put the Show Name and Show Date in the headers   ; �<< \ P u t   t h e   S h o w   N a m e   a n d   S h o w   D a t e   i n   t h e   h e a d e r s9 =>= r  Xu?@? o  X[�Y�Y 0 shownamelist ShowNameList@ n      ABA 4  ot�XC
�X 
cfloC m  rs�W�W B n  [oDED 4  ho�VF
�V 
TXTBF m  knGG �HH  O d d H e a d e rE n  [hIJI 4  ch�UK
�U 
sprdK m  fg�T�T J 4  [c�SL
�S 
MDOCL o  _b�R�R 0 docname DocName> M�QM r  v�NON o  vy�P�P 0 showdatelist ShowDateListO n      PQP 4  ���OR
�O 
cfloR m  ���N�N Q n  y�STS 4  ���MU
�M 
TXTBU m  ��VV �WW  E v e n H e a d e rT n  y�XYX 4  ���LZ
�L 
sprdZ m  ���K�K Y 4  y��J[
�J 
MDOC[ o  }��I�I 0 docname DocName�Q  6 m  RU\\�                                                                                  XPR3  alis    �  Macintosh HD               ���H+   Y�QuarkXPress.app                                                 ��у�S        ����  	                QuarkXPress 10    �!*      уڣ     Y�   0  :Macintosh HD:Applications: QuarkXPress 10: QuarkXPress.app     Q u a r k X P r e s s . a p p    M a c i n t o s h   H D  +Applications/QuarkXPress 10/QuarkXPress.app   / ��  �\  �[  3 ]�H] l     �G�F�E�G  �F  �E  �H   Z  This defines a subroutine    [ �^^ 2 T h i s   d e f i n e s   a   s u b r o u t i n e W _`_ l     �D�C�B�D  �C  �B  ` aba l     �A�@�?�A  �@  �?  b cdc h    �>e�> 0 
mainscript 
MainScripte l     fghf k      ii jkj l     �=�<�;�=  �<  �;  k lml l   tn�:�9n O    topo k   sqq rsr I   	�8�7�6
�8 .miscactvnull��� ��� null�7  �6  s tut l  
 
�5�4�3�5  �4  �3  u vwv l  
 
�2xy�2  x / )Set all variables that will be used later   y �zz R S e t   a l l   v a r i a b l e s   t h a t   w i l l   b e   u s e d   l a t e rw {|{ r   
 }~} I  
 �1�0
�1 .SATIUPPE****  @   @ **** l  
 ��/�.� n   
 ��� 1    �-
�- 
sisn� l  
 ��,�+� I  
 �*�)�(
�* .sysosigtsirr   ��� null�)  �(  �,  �+  �/  �.  �0  ~ o      �'�' 0 currentuser CurrentUser| ��� r    ��� 4    �&�
�& 
alis� m    �� ��� 0 M a c i n t o s h   H D : S H O W   F I L E S :� o      �%�% 0 localshowpath LocalShowPath� ��� r    %��� 4    #�$�
�$ 
alis� m   ! "�� ��� , M A C _ S E R V E R : S H O W   F I L E S :� o      �#�#  0 servershowpath ServerShowPath� ��� r   & -��� b   & +��� b   & )��� o   & '�"�" 0 localshowpath LocalShowPath� o   ' (�!�! 0 showcode ShowCode� m   ) *�� ��� 
 : C A T :� o      � �  0 catpath CATPath� ��� Z   . f����� =  . 1��� o   . /�� 0 docsize DocSize� m   / 0�� ���  N o r m a l� r   4 <��� 4   4 :��
� 
alis� m   6 9�� ��� d M A C _ S E R V E R : S H A R E D   F I L E S : T E M P L A T E S : C A T   T e m p l a t e . q p t� o      �� 0 cattemplate CATTemplate� ��� =  ? D��� o   ? @�� 0 docsize DocSize� m   @ C�� ���  M a g a z i n e� ��� r   G O��� 4   G M��
� 
alis� m   I L�� ��� v M A C _ S E R V E R : S H A R E D   F I L E S : T E M P L A T E S : C A T   T e m p l a t e   M a g a z i n e . q p t� o      �� 0 cattemplate CATTemplate� ��� =  R W��� o   R S�� 0 docsize DocSize� m   S V�� ���  L a r g e   P r i n t� ��� r   Z b��� 4   Z `��
� 
alis� m   \ _�� ��� | M A C _ S E R V E R : S H A R E D   F I L E S : T E M P L A T E S : C A T   T e m p l a t e   L a r g e   P r i n t . q p t� o      �� 0 cattemplate CATTemplate�  �  � ��� r   g n��� m   g j�� ���  � o      �� 0 
judgeerror 
JudgeError� ��� r   o v��� m   o r�� ���  � o      �� 0 	judgelist 	JudgeList� ��� r   w ���� l  w ����� N   w ��� c   w ���� l  w ����� b   w ���� b   w ���� b   w ~��� b   w |��� o   w x�� 0 catpath CATPath� m   x {�� ���  C A T� o   | }�� 0 showcode ShowCode� o   ~ ��� 0 
shownumber 
ShowNumber� m   � ��� ���  . t x t�  �  � m   � ��
� 
ctxt�  �  � o      �
�
 0 catalogtext CatalogText� ��� r   � ���� l  � ���	�� N   � ��� c   � ���� l  � ����� b   � ���� b   � ���� b   � ���� b   � ���� o   � ��� 0 catpath CATPath� m   � ��� ���  A G T� o   � ��� 0 showcode ShowCode� o   � ��� 0 
shownumber 
ShowNumber� m   � ��� ���  . t x t�  �  � m   � ��
� 
ctxt�	  �  � o      �� 0 
agentstext 
AgentsText� ��� r   � ���� l  � ��� ��� N   � ��� c   � �� � l  � ����� b   � � b   � � b   � � b   � �	 o   � ����� 0 catpath CATPath	 m   � �

 �  E X B o   � ����� 0 showcode ShowCode o   � ����� 0 
shownumber 
ShowNumber m   � � �  . t x t��  ��    m   � ���
�� 
ctxt�   ��  � o      ����  0 exhibitorstext ExhibitorsText�  r   � � l  � ����� N   � � c   � � l  � ����� b   � � b   � � b   � � o   � ����� 0 catpath CATPath o   � ����� 0 showcode ShowCode o   � ����� 0 
shownumber 
ShowNumber m   � � � "   J U D G E   R E P O R T . t x t��  ��   m   � ���
�� 
ctxt��  ��   o      ���� "0 judgereportpath JudgeReportPath   r   � �!"! m   � �## �$$  N o" o      ���� 0 needexbindex NeedExbIndex  %&% r   � �'(' m   � �)) �**  N o( o      ���� 0 hasexbindex HasExbIndex& +,+ r   � �-.- m   � �// �00  . o      ���� 0 shownamelist ShowNameList, 121 r   � �343 m   � �55 �66  4 o      ���� 0 showdatelist ShowDateList2 787 r   �9:9 b   �;<; l  � =����= c   � >?> l  � �@����@ I  � ���A��
�� .earsffdralis        afdrA m   � ���
�� afdrscr���  ��  ��  ? m   � ���
�� 
ctxt��  ��  < m   BB �CC \ C A T   P a s t e u p . a p p : C o n t e n t s : R e s o u r c e s : J L i c o n . i c n s: o      ���� 0 iconpath iconPath8 DED l 		��������  ��  ��  E FGF l 		��HI��  H F @Do these checks only if a new catalog is created from a template   I �JJ � D o   t h e s e   c h e c k s   o n l y   i f   a   n e w   c a t a l o g   i s   c r e a t e d   f r o m   a   t e m p l a t eG KLK Z  	qMN��OM = 	PQP o  	���� 0 usecurrentdoc UseCurrentDocQ m  RR �SS  N oN k  �TT UVU l ��������  ��  ��  V WXW l ��YZ��  Y L FCheck to make sure Show Code Folder exists and this computer OR server   Z �[[ � C h e c k   t o   m a k e   s u r e   S h o w   C o d e   F o l d e r   e x i s t s   a n d   t h i s   c o m p u t e r   O R   s e r v e rX \]\ Z  �^_����^ F  :`a` l #b����b H  #cc l "d����d I "��e��
�� .coredoexbool        obj e n  fgf 4  ��h
�� 
cfolh o  ���� 0 showcode ShowCodeg 4  ��i
�� 
cfoli o  ����  0 servershowpath ServerShowPath��  ��  ��  ��  ��  a l &6j����j H  &6kk l &5l����l I &5��m��
�� .coredoexbool        obj m n  &1non 4  ,1��p
�� 
cfolp o  /0���� 0 showcode ShowCodeo 4  &,��q
�� 
cfolq o  *+���� 0 localshowpath LocalShowPath��  ��  ��  ��  ��  _ t  =}rsr k  A|tt uvu O AOwxw I EN��y��
�� .aevtquitnull���    obj y l EJz����z I EJ������
�� .miscactvnull��� ��� null��  ��  ��  ��  ��  x  f  ABv {|{ I Pq��}~
�� .sysodlogaskr        TEXT} b  PY� b  PU��� m  PS�� ���  T h e  � o  ST���� 0 showcode ShowCode� m  UX�� ��� �   S h o w   F o l d e r   d o e s n ' t   e x i s t .   P l e a s e   c h e c k   t h e   S h o w   C o d e   a n d   t r y   a g a i n .~ ����
�� 
btns� J  \a�� ���� m  \_�� ���  C a n c e l��  � ����
�� 
dflt� m  de���� � �����
�� 
disp� m  hk��
�� stic    ��  | ���� O r|��� I v{������
�� .aevtquitnull���    obj ��  ��  �  f  rs��  s m  =@������  ��  ] ��� l ����������  ��  ��  � ��� l ��������  � B <Check to see if the Show Code Folder exists on the server OK   � ��� x C h e c k   t o   s e e   i f   t h e   S h o w   C o d e   F o l d e r   e x i s t s   o n   t h e   s e r v e r   O K� ��� Z  ��������� H  ���� l �������� I �������
�� .coredoexbool        obj � n  ����� 4  �����
�� 
cfol� o  ������ 0 showcode ShowCode� 4  �����
�� 
cfol� o  ������  0 servershowpath ServerShowPath��  ��  ��  � t  ����� k  ���� ��� O ����� I �������
�� .aevtquitnull���    obj � l �������� I ��������
�� .miscactvnull��� ��� null��  ��  ��  ��  ��  �  f  ��� ��� I ������
�� .sysodlogaskr        TEXT� b  ����� b  ����� m  ���� ���  T h e  � o  ������ 0 showcode ShowCode� m  ���� ��� �   S h o w   F o l d e r   d o e s n ' t   e x i s t .   P l e a s e   c h e c k   t h e   S h o w   C o d e   a n d   t r y   a g a i n .� ����
�� 
btns� J  ���� ���� m  ���� ���  C a n c e l��  � ����
�� 
dflt� m  ������ � �����
�� 
disp� m  ����
�� stic    ��  � ���� O ����� I ��������
�� .aevtquitnull���    obj ��  ��  �  f  ����  � m  ��������  ��  � ��� l ����������  ��  ��  � ��� l ��������  � A ;Check to see if Show Code Folder exists on this computer OK   � ��� v C h e c k   t o   s e e   i f   S h o w   C o d e   F o l d e r   e x i s t s   o n   t h i s   c o m p u t e r   O K� ��� Z  �0������� I �������
�� .coredoexbool        obj � n  ����� 4  �����
�� 
cfol� o  ������ 0 showcode ShowCode� 4  ����
� 
cfol� o  ���~�~ 0 localshowpath LocalShowPath��  � t  �,��� k  �+�� ��� O ����� I ���}��|
�} .aevtquitnull���    obj � l ����{�z� I ���y�x�w
�y .miscactvnull��� ��� null�x  �w  �{  �z  �|  �  f  ��� ��� I � �v��
�v .sysodlogaskr        TEXT� b  ���� b  ���� m  ��� ��� . A   f o l d e r   w i t h   t h e   n a m e  � o  �u�u 0 showcode ShowCode� m  �� ��� �   i s   a l r e a d y   o n   t h i s   c o m p u t e r .   P l e a s e   c h e c k   t h e   S h o w   C o d e   a n d   t r y   a g a i n .� �t��
�t 
btns� J  �� ��s� m  �� ���  C a n c e l�s  � �r��
�r 
dflt� m  �q�q � �p��o
�p 
disp� m  �n
�n stic    �o  � ��m� O !+��� I %*�l�k�j
�l .aevtquitnull���    obj �k  �j  �  f  !"�m  � m  ���i�i��  ��  � ��� l 11�h�g�f�h  �g  �f  � ��� l 11�e���e  � . (Check to see if IMPOSITION folder exists   � ��� P C h e c k   t o   s e e   i f   I M P O S I T I O N   f o l d e r   e x i s t s� ��� Z  1� �d�c  I 1S�b�a
�b .coredoexbool        obj  l 1O�`�_ 6 1O n  1@ m  <@�^
�^ 
cfol n  1<	 4  7<�]

�] 
cfol
 o  :;�\�\ 0 showcode ShowCode	 4  17�[
�[ 
cfol o  56�Z�Z  0 servershowpath ServerShowPath C  CN 1  DH�Y
�Y 
pnam m  IM �  I M P O S E D   O N  �`  �_  �a   t  V� k  Z�  O Zh I ^g�X�W
�X .aevtquitnull���    obj  l ^c�V�U I ^c�T�S�R
�T .miscactvnull��� ��� null�S  �R  �V  �U  �W    f  Z[  I i��Q
�Q .sysodlogaskr        TEXT b  iv b  ir  b  in!"! m  il## �$$  T h e  " o  lm�P�P 0 showcode ShowCode  o  nq�O�O 0 
shownumber 
ShowNumber m  ru%% �&& �   C a t a l o g   h a s   a l r e a d y   b e e n   i m p o s e d .     P l e a s e   c h e c k   t h e   S h o w   C o d e   a n d   t r y   a g a i n . �N'(
�N 
btns' J  y~)) *�M* m  y|++ �,,  C a n c e l�M  ( �L-.
�L 
dflt- m  ���K�K . �J/�I
�J 
disp/ m  ���H
�H stic    �I   0�G0 O ��121 I ���F�E�D
�F .aevtquitnull���    obj �E  �D  2  f  ���G   m  VY�C�C�d  �c  � 343 l ���B�A�@�B  �A  �@  4 565 l ���?78�?  7 ? 9Check to see if catalog text file has been transferred OK   8 �99 r C h e c k   t o   s e e   i f   c a t a l o g   t e x t   f i l e   h a s   b e e n   t r a n s f e r r e d   O K6 :;: Z  �<=�>�=< H  ��>> l ��?�<�;? I ���:@�9
�: .coredoexbool        obj @ n  ��ABA 4  ���8C
�8 
fileC l ��D�7�6D b  ��EFE b  ��GHG b  ��IJI m  ��KK �LL  C A TJ o  ���5�5 0 showcode ShowCodeH o  ���4�4 0 
shownumber 
ShowNumberF m  ��MM �NN  . t x t�7  �6  B n  ��OPO 4  ���3Q
�3 
cfolQ m  ��RR �SS  C A TP n  ��TUT 4  ���2V
�2 
cfolV o  ���1�1 0 showcode ShowCodeU 4  ���0W
�0 
cfolW o  ���/�/  0 servershowpath ServerShowPath�9  �<  �;  = t  ��XYX k  ��ZZ [\[ I ���.]^
�. .sysodlogaskr        TEXT] b  ��_`_ b  ��aba b  ��cdc m  ��ee �ff  T h e  d o  ���-�- 0 showcode ShowCodeb o  ���,�, 0 
shownumber 
ShowNumber` m  ��gg �hh �   C a t a l o g   T e x t   h a s   n o t   b e e n   t r a n s f e r r e d   f r o m   t h e   I B M .     T r a n s f e r   t h e m   a n d   t r y   a g a i n .^ �+ij
�+ 
btnsi J  ��kk l�*l m  ��mm �nn  C a n c e l�*  j �)op
�) 
dflto m  ���(�( p �'q�&
�' 
dispq m  ���%
�% stic    �&  \ r�$r O ��sts I ���#�"�!
�# .aevtquitnull���    obj �"  �!  t  f  ���$  Y m  ��� � �>  �=  ; uvu l ����  �  �  v wxw l �yz�  y G ACheck to see if Index to Agents text file has been transferred OK   z �{{ � C h e c k   t o   s e e   i f   I n d e x   t o   A g e n t s   t e x t   f i l e   h a s   b e e n   t r a n s f e r r e d   O Kx |}| Z  w~��~ H  ,�� l +���� I +���
� .coredoexbool        obj � n  '��� 4  '��
� 
file� l &���� b  &��� b  "��� b  ��� m  �� ���  A G T� o  �� 0 showcode ShowCode� o  !�� 0 
shownumber 
ShowNumber� m  "%�� ���  . t x t�  �  � n  ��� 4  ��
� 
cfol� m  �� ���  C A T� n  ��� 4  
��
� 
cfol� o  �� 0 showcode ShowCode� 4  
��
� 
cfol� o  	��  0 servershowpath ServerShowPath�  �  �   t  /s��� k  3r�� ��� O 3A��� I 7@���

� .aevtquitnull���    obj � l 7<��	�� I 7<���
� .miscactvnull��� ��� null�  �  �	  �  �
  �  f  34� ��� I Bg���
� .sysodlogaskr        TEXT� b  BO��� b  BK��� b  BG��� m  BE�� ���  T h e  � o  EF�� 0 showcode ShowCode� o  GJ�� 0 
shownumber 
ShowNumber� m  KN�� ��� �   A g e n t s   T e x t   h a s   n o t   b e e n   t r a n s f e r r e d   f r o m   t h e   I B M .     T r a n s f e r   t h e m   a n d   t r y   a g a i n .� ���
� 
btns� J  RW�� �� � m  RU�� ���  C a n c e l�   � ����
�� 
dflt� m  Z[���� � �����
�� 
disp� m  ^a��
�� stic    ��  � ���� O hr��� I lq������
�� .aevtquitnull���    obj ��  ��  �  f  hi��  � m  /2�����  �  } ��� l xx��������  ��  ��  � ��� l xx������  �  Get list of Groups   � ��� $ G e t   l i s t   o f   G r o u p s� ��� r  x���� l x������� 6 x���� n  x���� 1  ����
�� 
pnam� n  x���� 2  ����
�� 
file� 4  x����
�� 
cfol� l |������� c  |���� l |������� b  |���� b  |��� o  |}����  0 servershowpath ServerShowPath� o  }~���� 0 showcode ShowCode� m  ��� ��� 
 : C A T :��  ��  � m  ����
�� 
ctxt��  ��  � C  ����� 1  ����
�� 
pnam� m  ���� ���  G R P��  ��  � o      ���� 0 groupfilelist GroupFileList� ��� r  ����� I �������
�� .corecnte****       ****� n  ����� 2 ����
�� 
cobj� o  ������ 0 groupfilelist GroupFileList��  � o      ����  0 groupfilecount GroupFileCount� ��� l ����������  ��  ��  � ��� l ��������  � R LCheck to see if Group files have been transferred and Use Headers checked OK   � ��� � C h e c k   t o   s e e   i f   G r o u p   f i l e s   h a v e   b e e n   t r a n s f e r r e d   a n d   U s e   H e a d e r s   c h e c k e d   O K� ��� Z  ��������� F  ����� = ����� o  ������ 0 
useheaders 
UseHeaders� m  ���� ���  Y e s� =  ����� o  ������  0 groupfilecount GroupFileCount� m  ������  � t  ����� k  ���� ��� I ������
�� .sysodlogaskr        TEXT� b  ��� � b  �� m  �� �  T h e   o  ������ 0 showcode ShowCode  m  �� � �   S h o w   F o l d e r   d o e s n ' t   c o n t a i n   a n y   G r o u p   f i l e s .     H e a d e r s   w i l l   n o t   b e   u s e d .     A r e   y o u   s u r e   y o u   w a n t   t o   c o n t i n u e ?� ��
�� 
btns J  ��		 

 m  �� �  C a n c e l �� m  �� �  O K��   ��
�� 
dflt m  ������  ����
�� 
disp m  ����
�� stic   ��  � �� r  �� m  �� �  N o o      ���� 0 
useheaders 
UseHeaders��  � m  ��������  ��  �  l   ��������  ��  ��    l   ����   T NCheck to see if Group files have been transferred and Use Headers unchecked OK    � � C h e c k   t o   s e e   i f   G r o u p   f i l e s   h a v e   b e e n   t r a n s f e r r e d   a n d   U s e   H e a d e r s   u n c h e c k e d   O K  !  Z   C"#����" F   $%$ =  &'& o   ���� 0 
useheaders 
UseHeaders' m  (( �))  N o% =  
*+* o  
����  0 groupfilecount GroupFileCount+ m  ����  # t  ?,-, I >��./
�� .sysodlogaskr        TEXT. b  #010 b  232 m  44 �55  T h e  3 o  ���� 0 showcode ShowCode1 m  "66 �77 �   S h o w   F o l d e r   d o e s n ' t   c o n t a i n   a n y   G r o u p   f i l e s .     A r e   y o u   s u r e   y o u   w a n t   t o   c o n t i n u e ?/ ��89
�� 
btns8 J  &.:: ;<; m  &)== �>>  C a n c e l< ?��? m  ),@@ �AA  O K��  9 ��BC
�� 
dfltB m  12���� C ��D��
�� 
dispD m  58��
�� stic   ��  - m  ������  ��  ! EFE l DD��������  ��  ��  F GHG l DD��IJ��  I > 8Check to see if the CAT file has already been created OK   J �KK p C h e c k   t o   s e e   i f   t h e   C A T   f i l e   h a s   a l r e a d y   b e e n   c r e a t e d   O KH LML Z  D�NO����N I Dg��P��
�� .coredoexbool        obj P n  DcQRQ 4  Vc��S
�� 
fileS l YbT����T b  YbUVU b  Y^WXW o  YZ���� 0 showcode ShowCodeX o  Z]���� 0 
shownumber 
ShowNumberV m  ^aYY �ZZ    C A T��  ��  R n  DV[\[ 4  OV��]
�� 
cfol] m  RU^^ �__  C A T\ n  DO`a` 4  JO��b
�� 
cfolb o  MN���� 0 showcode ShowCodea 4  DJ��c
�� 
cfolc o  HI����  0 servershowpath ServerShowPath��  O t  j�ded I n���fg
�� .sysodlogaskr        TEXTf b  n{hih b  nwjkj b  nslml m  nqnn �oo  T h e  m o  qr���� 0 showcode ShowCodek o  sv���� 0 
shownumber 
ShowNumberi m  wzpp �qq �   C a t a l o g   a l r e a d y   e x i s t s   o n   M A C _ S E R V E R .   A R E   Y O U   S U R E   y o u   w a n t   t o   O V E R W R I T E   t h i s   f i l e ?g ��rs
�� 
btnsr J  ~�tt uvu m  ~�ww �xx  C a n c e lv y��y m  ��zz �{{  O K��  s ��|}
�� 
dflt| m  ������ } ��~��
�� 
disp~ m  ����
�� stic   ��  e m  jm������  ��  M � l ����������  ��  ��  � ��� t  �Y��� k  �X�� ��� l ��������  � 6 0Copy folders from the server to this computer OK   � ��� ` C o p y   f o l d e r s   f r o m   t h e   s e r v e r   t o   t h i s   c o m p u t e r   O K� ��� I ������
�� .corecrel****      � null� n ����� m  ����
�� 
cfol� o  ������ 0 localshowpath LocalShowPath� �����
�� 
prdt� K  ���� �����
�� 
pnam� o  ������ 0 showcode ShowCode��  ��  � ��� I ������
�� .coreclon****      � ****� n  ����� 4  �����
�� 
cfol� m  ���� ���  C A T� n  ����� 4  �����
�� 
cfol� o  ������ 0 showcode ShowCode� 4  �����
�� 
cfol� o  ������  0 servershowpath ServerShowPath� �����
�� 
insh� n  ����� 4  �����
�� 
cfol� o  ������ 0 showcode ShowCode� 4  �����
�� 
cfol� o  ������ 0 localshowpath LocalShowPath��  � ��� I ������
�� .coreclon****      � ****� n  ����� 4  �����
�� 
cfol� m  ���� ���  E P S   I n s e r t s� n  ����� 4  ����
� 
cfol� o  ���~�~ 0 showcode ShowCode� 4  ���}�
�} 
cfol� o  ���|�|  0 servershowpath ServerShowPath� �{��z
�{ 
insh� n  ����� 4  ���y�
�y 
cfol� o  ���x�x 0 showcode ShowCode� 4  ���w�
�w 
cfol� o  ���v�v 0 localshowpath LocalShowPath�z  � ��� l ���u���u  � 1 +Delete contents of folders on the server OK   � ��� V D e l e t e   c o n t e n t s   o f   f o l d e r s   o n   t h e   s e r v e r   O K� ��� I ��t��s
�t .coredeloobj        obj � n  ���� 2  �r
�r 
file� n  ���� 4  �q�
�q 
cfol� m  �� ���  C A T� n  ���� 4  �p�
�p 
cfol� o  �o�o 0 showcode ShowCode� 4  ��n�
�n 
cfol� o  �m�m  0 servershowpath ServerShowPath�s  � ��� I 2�l��k
�l .coredeloobj        obj � n  .��� 2  *.�j
�j 
file� n  *��� 4  #*�i�
�i 
cfol� m  &)�� ���  E P S   I n s e r t s� n  #��� 4  #�h�
�h 
cfol� o  !"�g�g 0 showcode ShowCode� 4  �f�
�f 
cfol� o  �e�e  0 servershowpath ServerShowPath�k  � ��� l 33�d���d  � < 6Change EPS Inserts folder to indicate checker-outer OK   � ��� l C h a n g e   E P S   I n s e r t s   f o l d e r   t o   i n d i c a t e   c h e c k e r - o u t e r   O K� ��c� r  3X��� K  3A�� �b��a
�b 
pnam� l 6?��`�_� b  6?��� b  6;��� m  69�� ���  O n  � o  9:�^�^ 0 currentuser CurrentUser� m  ;>�� ���  ' s   C o m p u t e r�`  �_  �a  � n      ��� 1  SW�]
�] 
pALL� n  AS��� 4  LS�\�
�\ 
cfol� m  OR�� ���  E P S   I n s e r t s� n  AL��� 4  GL�[�
�[ 
cfol� o  JK�Z�Z 0 showcode ShowCode� 4  AG�Y�
�Y 
cfol� o  EF�X�X  0 servershowpath ServerShowPath�c  � m  ���W�W� ��� l ZZ�V�U�T�V  �U  �T  � ��� l ZZ�S���S  � $ Open blank catalog template OK   � ��� < O p e n   b l a n k   c a t a l o g   t e m p l a t e   O K� ��� O  Z�   k  `�  I `y�R
�R .aevtodocnull  �    alis c  `c o  `a�Q�Q 0 cattemplate CATTemplate m  ab�P
�P 
alis �O	

�O 
KPRF	 m  fi�N
�N savoyes 
 �M
�M 
KAUP m  lo�L
�L savono   �K�J
�K 
RFLW m  rs�I
�I boovfals�J    I z�H�G
�H .sysodelanull��� ��� nmbr m  z{�F�F �G   �E r  �� n  �� 1  ���D
�D 
pnam 4  ���C
�C 
docu m  ���B�B  o      �A�A 0 docname DocName�E   m  Z]�                                                                                  XPR3  alis    �  Macintosh HD               ���H+   Y�QuarkXPress.app                                                 ��у�S        ����  	                QuarkXPress 10    �!*      уڣ     Y�   0  :Macintosh HD:Applications: QuarkXPress 10: QuarkXPress.app     Q u a r k X P r e s s . a p p    M a c i n t o s h   H D  +Applications/QuarkXPress 10/QuarkXPress.app   / ��  � �@ l ���?�>�=�?  �>  �=  �@  ��  O l �q k  �q  l ���<�;�:�<  �;  �:     O  ��!"! k  ��## $%$ I ���9�8�7
�9 .miscactvnull��� ��� null�8  �7  % &'& l ���6�5�4�6  �5  �4  ' ()( l ���3*+�3  * . (Check to make sure a document is open OK   + �,, P C h e c k   t o   m a k e   s u r e   a   d o c u m e n t   i s   o p e n   O K) -.- Z  ��/0�2�1/ H  ��11 l ��2�0�/2 I ���.3�-
�. .coredoexbool        obj 3 4  ���,4
�, 
docu4 m  ���+�+ �-  �0  �/  0 t  ��565 k  ��77 898 O ��:;: I ���*<�)
�* .aevtquitnull���    obj < l ��=�(�'= I ���&�%�$
�& .miscactvnull��� ��� null�%  �$  �(  �'  �)  ;  f  ��9 >?> I ���#@A
�# .sysodlogaskr        TEXT@ m  ��BB �CC � U s e   C u r r e n t   B o x   w a s   c h e c k e d ,   b u t   t h e r e   i s   n o   d o c u m e n t   o p e n .     P l e a s e   o p e n   a   c a t a l o g   d o c u m e n t   a n d   t r y   a g a i n .A �"DE
�" 
btnsD J  ��FF G�!G m  ��HH �II  C a n c e l�!  E � JK
�  
dfltJ m  ���� K �L�
� 
dispL m  ���
� stic    �  ? M�M O ��NON I �����
� .aevtquitnull���    obj �  �  O  f  ���  6 m  �����2  �1  . PQP l ������  �  �  Q RSR l ���TU�  T - 'Check to make sure a StartBox exists OK   U �VV N C h e c k   t o   m a k e   s u r e   a   S t a r t B o x   e x i s t s   O KS WXW Z  ��YZ[�Y F  �\]\ H  �^^ l � _��_ I � �`�
� .coredoexbool        obj ` n  ��aba 4  ���c
� 
TXTBc m  ��dd �ee  S t a r t B o xb 4  ���f
� 
docuf o  ���� 0 docname DocName�  �  �  ] l g�
�	g > hih n  jkj m  	�
� 
pclsk 1  	�
� 
CUBXi m  �
� 
TXTB�
  �	  Z t  Rlml k  Qnn opo O *qrq I  )�s�
� .aevtquitnull���    obj s l  %t��t I  %�� ��
� .miscactvnull��� ��� null�   ��  �  �  �  r  f  p uvu I +F��wx
�� .sysodlogaskr        TEXTw m  +.yy �zz � P l e a s e   s e l e c t   t h e   t e x t   b o x   t o   p a s t e   c a t a l o g   e n t r i e s   i n t o   b e f o r e   r u n n i n g   t h i s   s c r i p t .x ��{|
�� 
btns{ J  16}} ~��~ m  14 ���  C a n c e l��  | ����
�� 
dflt� m  9:���� � �����
�� 
disp� m  =@��
�� stic    ��  v ���� O GQ��� I KP������
�� .aevtquitnull���    obj ��  ��  �  f  GH��  m m  ����[ ��� H  Ui�� l Uh������ I Uh�����
�� .coredoexbool        obj � n  Ud��� 4  ]d���
�� 
TXTB� m  `c�� ���  S t a r t B o x� 4  U]���
�� 
docu� o  Y\���� 0 docname DocName��  ��  ��  � ���� k  l��� ��� t  l���� I p�����
�� .sysodlogaskr        TEXT� m  ps�� ��� � D o   y o u   w a n t   t o   u s e   t h e   s e l e c t e d   t e x t   b o x   t o   p a s t e   c a t a l o g   e n t r i e s   i n t o ?� ����
�� 
btns� J  v~�� ��� m  vy�� ���  C a n c e l� ���� m  y|�� ���  O K��  � ����
�� 
dflt� m  ������ � �����
�� 
disp� m  ����
�� stic   ��  � m  lo����� ���� r  ����� m  ���� ���  S t a r t B o x� n      ��� 1  ����
�� 
pnam� 1  ����
�� 
CUBX��  ��  �  X ���� l ����������  ��  ��  ��  " m  �����                                                                                  XPR3  alis    �  Macintosh HD               ���H+   Y�QuarkXPress.app                                                 ��у�S        ����  	                QuarkXPress 10    �!*      уڣ     Y�   0  :Macintosh HD:Applications: QuarkXPress 10: QuarkXPress.app     Q u a r k X P r e s s . a p p    M a c i n t o s h   H D  +Applications/QuarkXPress 10/QuarkXPress.app   / ��    ��� l ����������  ��  ��  � ��� l ��������  � C =Check to see if Show Code Folder exists on user's computer OK   � ��� z C h e c k   t o   s e e   i f   S h o w   C o d e   F o l d e r   e x i s t s   o n   u s e r ' s   c o m p u t e r   O K� ��� Z  �#������� H  ���� l �������� I �������
�� .coredoexbool        obj � n  ����� 4  �����
�� 
cfol� o  ������ 0 showcode ShowCode� 4  �����
�� 
cfol� o  ������ 0 localshowpath LocalShowPath��  ��  ��  � k  ��� ��� l ����������  ��  ��  � ��� r  ����� o  ������  0 servershowpath ServerShowPath� o      ���� 0 localshowpath LocalShowPath� ��� r  ����� b  ����� b  ����� o  ������ 0 localshowpath LocalShowPath� o  ������ 0 showcode ShowCode� m  ���� ��� 
 : C A T :� o      ���� 0 catpath CATPath� ��� l ����������  ��  ��  � ��� l ��������  � ; 5Check to see if Show Code Folder exists on the server   � ��� j C h e c k   t o   s e e   i f   S h o w   C o d e   F o l d e r   e x i s t s   o n   t h e   s e r v e r� ��� Z  �������� H  ���� l �������� I �������
�� .coredoexbool        obj � n  ����� 4  �����
�� 
cfol� o  ������ 0 showcode ShowCode� 4  �����
�� 
cfol� o  ������  0 servershowpath ServerShowPath��  ��  ��  � t  ���� k  ��� ��� O ����� I �������
�� .aevtquitnull���    obj � l �������� I ��������
�� .miscactvnull��� ��� null��  ��  ��  ��  ��  �  f  ��� ��� I �����
�� .sysodlogaskr        TEXT� b  ����� b  ����� m  ���� ���  T h e  � o  ������ 0 showcode ShowCode� m  ���� ��� �   S h o w   F o l d e r   d o e s n ' t   e x i s t .   P l e a s e   c h e c k   t h e   S h o w   C o d e   a n d   t r y   a g a i n .� ����
�� 
btns� J  ���� ���� m  ��   �  C a n c e l��  � ��
�� 
dflt m   ����  ����
�� 
disp m  ��
�� stic    ��  � �� O  I ������
�� .aevtquitnull���    obj ��  ��    f  ��  � m  ��������  ��  � �� l ��������  ��  ��  ��  ��  ��  � 	
	 l $$��������  ��  ��  
  l $$����   ? 9Check to see if catalog text file has been transferred OK    � r C h e c k   t o   s e e   i f   c a t a l o g   t e x t   f i l e   h a s   b e e n   t r a n s f e r r e d   O K  Z  $����� H  $D l $C���� I $C����
�� .coredoexbool        obj  n  $? 4  .?��
�� 
file l 1>���� b  1> b  1: b  16  m  14!! �""  C A T  o  45���� 0 showcode ShowCode o  69���� 0 
shownumber 
ShowNumber m  :=## �$$  . t x t��  ��   4  $.��%
�� 
cfol% l (-&����& c  (-'(' o  ()���� 0 catpath CATPath( m  ),��
�� 
ctxt��  ��  ��  ��  ��   t  G�)*) k  K�++ ,-, O KY./. I OX��0��
�� .aevtquitnull���    obj 0 l OT1����1 I OT������
�� .miscactvnull��� ��� null��  ��  ��  ��  ��  /  f  KL- 232 I Z��45
�� .sysodlogaskr        TEXT4 b  Zg676 b  Zc898 b  Z_:;: m  Z]<< �==  T h e  ; o  ]^���� 0 showcode ShowCode9 o  _b�� 0 
shownumber 
ShowNumber7 m  cf>> �?? �   C a t a l o g   T e x t   h a s   n o t   b e e n   t r a n s f e r r e d   f r o m   t h e   I B M .     T r a n s f e r   t h e m   a n d   t r y   a g a i n .5 �~@A
�~ 
btns@ J  joBB C�}C m  jmDD �EE  C a n c e l�}  A �|FG
�| 
dfltF m  rs�{�{ G �zH�y
�z 
dispH m  vy�x
�x stic    �y  3 I�wI O ��JKJ I ���v�u�t
�v .aevtquitnull���    obj �u  �t  K  f  ���w  * m  GJ�s�s��  ��   LML l ���r�q�p�r  �q  �p  M NON l ���oPQ�o  P G ACheck to see if Index to Agents text file has been transferred OK   Q �RR � C h e c k   t o   s e e   i f   I n d e x   t o   A g e n t s   t e x t   f i l e   h a s   b e e n   t r a n s f e r r e d   O KO STS Z  ��UV�n�mU H  ��WW l ��X�l�kX I ���jY�i
�j .coredoexbool        obj Y n  ��Z[Z 4  ���h\
�h 
file\ l ��]�g�f] b  ��^_^ b  ��`a` b  ��bcb m  ��dd �ee  A G Tc o  ���e�e 0 showcode ShowCodea o  ���d�d 0 
shownumber 
ShowNumber_ m  ��ff �gg  . t x t�g  �f  [ 4  ���ch
�c 
cfolh l ��i�b�ai c  ��jkj o  ���`�` 0 catpath CATPathk m  ���_
�_ 
ctxt�b  �a  �i  �l  �k  V t  ��lml k  ��nn opo O ��qrq I ���^s�]
�^ .aevtquitnull���    obj s l ��t�\�[t I ���Z�Y�X
�Z .miscactvnull��� ��� null�Y  �X  �\  �[  �]  r  f  ��p uvu I ���Wwx
�W .sysodlogaskr        TEXTw b  ��yzy b  ��{|{ b  ��}~} m  �� ���  T h e  ~ o  ���V�V 0 showcode ShowCode| o  ���U�U 0 
shownumber 
ShowNumberz m  ���� ��� �   A g e n t s   T e x t   h a s   n o t   b e e n   t r a n s f e r r e d   f r o m   t h e   I B M .     T r a n s f e r   t h e m   a n d   t r y   a g a i n .x �T��
�T 
btns� J  ���� ��S� m  ���� ���  C a n c e l�S  � �R��
�R 
dflt� m  ���Q�Q � �P��O
�P 
disp� m  ���N
�N stic    �O  v ��M� O ����� I ���L�K�J
�L .aevtquitnull���    obj �K  �J  �  f  ���M  m m  ���I�I�n  �m  T ��� l ���H�G�F�H  �G  �F  � ��� l ���E���E  �  Get list of Groups   � ��� $ G e t   l i s t   o f   G r o u p s� ��� r  �!��� l ���D�C� 6 ���� n  ���� 1  
�B
�B 
pnam� n  �
��� 2  
�A
�A 
file� 4  ��@�
�@ 
cfol� l  ��?�>� c   ��� o   �=�= 0 catpath CATPath� m  �<
�< 
ctxt�?  �>  � C  ��� 1  �;
�; 
pnam� m  �� ���  G R P�D  �C  � o      �:�: 0 groupfilelist GroupFileList� ��� r  "1��� I "-�9��8
�9 .corecnte****       ****� n  ")��� 2 %)�7
�7 
cobj� o  "%�6�6 0 groupfilelist GroupFileList�8  � o      �5�5  0 groupfilecount GroupFileCount� ��� l 22�4�3�2�4  �3  �2  � ��� l 22�1���1  � : 4Check to see if Group files have been transferred OK   � ��� h C h e c k   t o   s e e   i f   G r o u p   f i l e s   h a v e   b e e n   t r a n s f e r r e d   O K� ��� Z  2o���0�/� =  27��� o  25�.�.  0 groupfilecount GroupFileCount� m  56�-�-  � k  :k�� ��� t  :c��� I >b�,��
�, .sysodlogaskr        TEXT� b  >G��� b  >C��� m  >A�� ���  T h e  � o  AB�+�+ 0 showcode ShowCode� m  CF�� ��� �   S h o w   F o l d e r   d o e s n ' t   c o n t a i n   a n y   G r o u p   f i l e s .     A r e   y o u   s u r e   y o u   w a n t   t o   c o n t i n u e ?� �*��
�* 
btns� J  JR�� ��� m  JM�� ���  C a n c e l� ��)� m  MP�� ���  O K�)  � �(��
�( 
dflt� m  UV�'�' � �&��%
�& 
disp� m  Y\�$
�$ stic   �%  � m  :=�#�#� ��"� r  dk��� m  dg�� ���  N o� o      �!�! 0 
useheaders 
UseHeaders�"  �0  �/  � �� � l pp����  �  �  �    9 3Do these checks only if current document is used OK    ��� f D o   t h e s e   c h e c k s   o n l y   i f   c u r r e n t   d o c u m e n t   i s   u s e d   O KL ��� l rr����  �  �  �  p m     ���                                                                                  MACS  alis    t  Macintosh HD               ���H+   �
Finder.app                                                      Z��B�<        ����  	                CoreServices    �!*      �B�     � � �  6Macintosh HD:System: Library: CoreServices: Finder.app   
 F i n d e r . a p p    M a c i n t o s h   H D  &System/Library/CoreServices/Finder.app  / ��  �:  �9  m ��� l     ����  �  �  � ��� l      ����  � g a)--Call the OrderGroups subroutine OK
 with timeout of 3600 seconds
 run OrderGroups
 end timeout   � ��� � ) - - C a l l   t h e   O r d e r G r o u p s   s u b r o u t i n e   O K 
   w i t h   t i m e o u t   o f   3 6 0 0   s e c o n d s 
   r u n   O r d e r G r o u p s 
   e n d   t i m e o u t� ��� l     ����  �  �  � ��� l     ����  � I CIf user checked Use Headers then call the MakeHeaders subroutine OK   � ��� � I f   u s e r   c h e c k e d   U s e   H e a d e r s   t h e n   c a l l   t h e   M a k e H e a d e r s   s u b r o u t i n e   O K� ��� l u����� t  u���� Z y������ = y���� o  y|�� 0 
useheaders 
UseHeaders� m  |�� ���  Y e s� I �����

� .aevtoappnull  �   � ****� o  ���	�	 0 makeheaders MakeHeaders�
  �  �  � m  ux���  �  � ��� l     ����  �  �  � ��� l ��	 ��	  O  ��			 k  ��		 			 I ����� 
� .miscactvnull��� ��� null�  �   	 			 l ����������  ��  ��  	 				 t  �	V	
		
 Q  �	U				 l ��				 Z ��		����	 G  ��			 l ��	����	 = ��			 o  ������ 0 usecurrentdoc UseCurrentDoc	 m  ��		 �		  N o��  ��  	 l ��	����	 = ��			 l ��	����	 I ����	��
�� .corecnte****       ****	 n  ��	 	!	  2 ����
�� 
cha 	! n  ��	"	#	" 4  ����	$
�� 
cflo	$ m  ������ 	# n  ��	%	&	% 4  ����	'
�� 
TXTB	' m  ��	(	( �	)	)  S t a r t B o x	& 4  ����	*
�� 
docu	* o  ������ 0 docname DocName��  ��  ��  	 m  ������  ��  ��  	 r  ��	+	,	+ 4  ����	-
�� 
file	- o  ������ 0 catalogtext CatalogText	, n      	.	/	. 4  ����	0
�� 
cflo	0 m  ������ 	/ n  ��	1	2	1 4  ����	3
�� 
TXTB	3 m  ��	4	4 �	5	5  S t a r t B o x	2 4  ����	6
�� 
docu	6 o  ������ 0 docname DocName��  ��  	  Import the Catalog text   	 �	7	7 . I m p o r t   t h e   C a t a l o g   t e x t	 R      ������
�� .ascrerr ****      � ****��  ��  	 l �	U	8	9	:	8 t  �	U	;	<	; k  �	T	=	= 	>	?	> I �	��	@	A
�� .coreclosnull���    obj 	@ 4  �	��	B
�� 
docu	B o  		���� 0 docname DocName	A ��	C��
�� 
savo	C m  	
	��
�� savono  ��  	? 	D	E	D O 			F	G	F I 		������
�� .aevtquitnull���    obj ��  ��  	G m  			H	H�                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  	E 	I	J	I O 		-	K	L	K I 	#	,��	M��
�� .aevtquitnull���    obj 	M l 	#	(	N����	N I 	#	(������
�� .miscactvnull��� ��� null��  ��  ��  ��  ��  	L  f  		 	J 	O	P	O I 	.	I��	Q	R
�� .sysodlogaskr        TEXT	Q m  	.	1	S	S �	T	T � T h e r e   i s   n o   C a t a l o g   t e x t   t o   i m p o r t .     C h e c k   t h e   S h o w   C o d e   a n d / o r   t r a n s f e r   t h e   c a t a l o g   a n d   t r y   a g a i n .	R ��	U	V
�� 
btns	U J  	4	9	W	W 	X��	X m  	4	7	Y	Y �	Z	Z  C a n c e l��  	V ��	[	\
�� 
dflt	[ m  	<	=���� 	\ ��	]��
�� 
disp	] m  	@	C��
�� stic    ��  	P 	^��	^ O 	J	T	_	`	_ I 	N	S������
�� .aevtquitnull���    obj ��  ��  	`  f  	J	K��  	< m  ������	9 ! Quit script and notify user   	: �	a	a 6 Q u i t   s c r i p t   a n d   n o t i f y   u s e r	 m  ������		 	b	c	b l 	W	W��������  ��  ��  	c 	d	e	d t  	W	�	f	g	f k  	[	�	h	h 	i	j	i l 	[	[��	k	l��  	k 4 .Force QXP to draw all the pages in document OK   	l �	m	m \ F o r c e   Q X P   t o   d r a w   a l l   t h e   p a g e s   i n   d o c u m e n t   O K	j 	n	o	n I 	[	x��	p��
�� .miscmvisnull���    obj 	p n  	[	t	q	r	q 4 	o	t��	s
�� 
cha 	s m  	r	s������	r n  	[	o	t	u	t 4  	j	o��	v
�� 
cflo	v m  	m	n���� 	u n  	[	j	w	x	w 4  	c	j��	y
�� 
TXTB	y m  	f	i	z	z �	{	{  S t a r t B o x	x 4  	[	c��	|
�� 
docu	| o  	_	b���� 0 docname DocName��  	o 	}��	} I 	y	���	~��
�� .miscmvisnull���    obj 	~ n  	y	�		�	 4  	�	���	�
�� 
page	� m  	�	����� 	� 4  	y	���	�
�� 
docu	� o  	}	����� 0 docname DocName��  ��  	g m  	W	Z����	e 	�	�	� l 	�	���������  ��  ��  	� 	�	�	� t  	�U	�	�	� k  	�T	�	� 	�	�	� l 	�	���������  ��  ��  	� 	�	�	� O  	�H	�	�	� k  	�G	�	� 	�	�	� l 	�	���������  ��  ��  	� 	�	�	� l 	�	���	�	���  	�  Set some variables   	� �	�	� $ S e t   s o m e   v a r i a b l e s	� 	�	�	� r  	�	�	�	�	� m  	�	����� 	� o      ���� 0 paracounter ParaCounter	� 	�	�	� l 	�	���������  ��  ��  	� 	�	�	� l 	�	���	�	���  	�  Start the ParaCount   	� �	�	� & S t a r t   t h e   P a r a C o u n t	� 	�	�	� r  	�	�	�	�	� c  	�	�	�	�	� l 	�	�	�����	� I 	�	���	���
�� .corecnte****       ****	� n  	�	�	�	�	� 2 	�	���
�� 
cpar	� n  	�	�	�	�	� 4  	�	���	�
�� 
cflo	� m  	�	����� 	� 4  	�	���	�
�� 
TXTB	� m  	�	�	�	� �	�	�  S t a r t B o x��  ��  ��  	� m  	�	���
�� 
TEXT	� o      ���� 0 	paracount 	ParaCount	� 	�	�	� l 	�	���������  ��  ��  	� 	�	�	� O  	�
)	�	�	� k  	�
(	�	� 	�	�	� I 	�	�������
�� .miscactvnull��� ��� null��  ��  	� 	�	�	� r  	�	�	�	�	� m  	�	�	�	� �	�	�  C A T   P a s t e u p	� 1  	�	���
�� 
titl	� 	�	�	� r  	�	�	�	�	� m  	�	�	�	� �	�	� @ P r e p a r i n g   c a t a l o g   f o r   p a s t e u p . . .	� 1  	�	���
�� 
hEaR	� 	�	�	� r  	�	�	�	�	� m  	�	�	�	� �	�	� 2 C o p y r i g h t   1 9 9 6   J a m e s   L a k e	� 1  	�	���
�� 
fOtR	� 	�	�	� r  	�	�	�	�	� m  	�	���
�� aliNriTA	� 1  	�	���
�� 
fTaG	� 	�	�	� r  	�	�	�	�	� o  	�	����� 0 iconpath iconPath	� 1  	�	���
�� 
iMGe	� 	�	�	� r  	�
	�	�	� m  	�	���
�� boovtrue	� 1  	�
��
�� 
sHwD	� 	���	� O  

(	�	�	� k  

'	�	� 	�	�	� r  

	�	�	� m  

��
�� boovfals	� 1  

��
�� 
iDtM	� 	�	�	� I 

�����
�� .pGbRStMnnull���     ****��  �  	� 	��~	� r  

'	�	�	� l 

!	��}�|	� [  

!	�	�	� o  

�{�{ 0 	paracount 	ParaCount	� m  

 �z�z �}  �|  	� 1  
!
&�y
�y 
vMaX�~  	� 1  

�x
�x 
cRpB��  	� m  	�	�	�	��                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  	� 	�	�	� l 
*
*�w�v�u�w  �v  �u  	� 	�	�	� T  
*?	�	� l 
/:	�	�	�	� k  
/:	�	� 	�	�	� l 
/
/�t�s�r�t  �s  �r  	� 	�	�	� O  
/
X	�	�	� k  
5
W	�	� 	�	�	� r  
5
D	�	�	� l 
5
>	��q�p	� c  
5
>
 

  l 
5
:
�o�n
 b  
5
:


 o  
5
6�m�m 0 	paracount 	ParaCount
 m  
6
9

 �

 2   p a r a g r a p h s   l e f t   t o   c h e c k�o  �n  
 m  
:
=�l
�l 
ctxt�q  �p  	� 1  
>
C�k
�k 
hEaR	� 
�j
 O  
E
W

	
 I 
M
V�i�h


�i .pGbRIcRmnull���     ****�h  

 �g
�f
�g 
bYVl
 m  
Q
R�e�e �f  
	 1  
E
J�d
�d 
cRpB�j  	� m  
/
2

�                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  	� 


 l 
Y
Y�c�b�a�c  �b  �a  
 


 O  
Y,


 k  
i+

 


 l 
i
i�`�_�^�`  �_  �^  
 


 l 
i
i�]

�]  
 : 4Exit the loop after checking the last paragraph --OK   
 �

 h E x i t   t h e   l o o p   a f t e r   c h e c k i n g   t h e   l a s t   p a r a g r a p h   - - O K
 


 Z 
i
|

�\�[
 =  
i
t

 
 o  
i
j�Z�Z 0 paracounter ParaCounter
  l 
j
s
!�Y�X
! I 
j
s�W
"�V
�W .corecnte****       ****
" 2 
j
o�U
�U 
cpar�V  �Y  �X  
  S  
w
x�\  �[  
 
#
$
# l 
}
}�T�S�R�T  �S  �R  
$ 
%
&
% Q  
}
�
'
(�Q
' l 
�
�
)
*
+
) k  
�
�
,
, 
-
.
- r  
�
�
/
0
/ n  
�
�
1
2
1 1  
�
��P
�P 
pnam
2 n  
�
�
3
4
3 1  
�
��O
�O 
PRSS
4 4  
�
��N
5
�N 
cpar
5 o  
�
��M�M 0 paracounter ParaCounter
0 o      �L�L 0 ssname SSName
. 
6�K
6 r  
�
�
7
8
7 n  
�
�
9
:
9 1  
�
��J
�J 
pnam
: n  
�
�
;
<
; 1  
�
��I
�I 
PRSS
< 4  
�
��H
=
�H 
cpar
= l 
�
�
>�G�F
> [  
�
�
?
@
? o  
�
��E�E 0 paracounter ParaCounter
@ m  
�
��D�D �G  �F  
8 o      �C�C 0 ssnameplus1 SSNamePlus1�K  
* E ?Convert paragraph style names to text for quicker checking --OK   
+ �
A
A ~ C o n v e r t   p a r a g r a p h   s t y l e   n a m e s   t o   t e x t   f o r   q u i c k e r   c h e c k i n g   - - O K
( R      �B�A�@
�B .ascrerr ****      � ****�A  �@  �Q  
& 
B
C
B l 
�
��?�>�=�?  �>  �=  
C 
D
E
D Q  
�
�
F
G�<
F l 
�
�
H
I
J
H Z 
�
�
K
L�;�:
K F  
�
�
M
N
M = 
�
�
O
P
O o  
�
��9�9 0 ssname SSName
P m  
�
�
Q
Q �
R
R 
 E n t r y
N = 
�
�
S
T
S n  
�
�
U
V
U 4 
�
��8
W
�8 
cha 
W m  
�
��7�7 
V 4  
�
��6
X
�6 
cpar
X o  
�
��5�5 0 paracounter ParaCounter
T m  
�
�
Y
Y �
Z
Z  _
L r  
�
�
[
\
[ m  
�
��4
�4 boovtrue
\ n      
]
^
] 1  
�
��3
�3 
kewn
^ 4  
�
��2
_
�2 
cpar
_ l 
�
�
`�1�0
` \  
�
�
a
b
a o  
�
��/�/ 0 paracounter ParaCounter
b m  
�
��.�. �1  �0  �;  �:  
I V PMake the line after an obedience entry in a single show stick with the entry -OK   
J �
c
c � M a k e   t h e   l i n e   a f t e r   a n   o b e d i e n c e   e n t r y   i n   a   s i n g l e   s h o w   s t i c k   w i t h   t h e   e n t r y   - O K
G R      �-�,�+
�- .ascrerr ****      � ****�,  �+  �<  
E 
d
e
d l 
�
��*�)�(�*  �)  �(  
e 
f
g
f Q  
�7
h
i�'
h l 
�.
j
k
l
j Z 
�.
m
n�&�%
m F  
�
o
p
o = 
�
�
q
r
q n  
�
�
s
t
s 1  
�
��$
�$ 
kewn
t 4  
�
��#
u
�# 
cpar
u o  
�
��"�" 0 paracounter ParaCounter
r m  
�
��!
�! boovtrue
p = 
�
v
w
v l 
�
x� �
x I 
��
y
z
� .XPRSCOER****���    ****
y l 
�	
{��
{ e  
�	
|
| n  
�	
}
~
} 1  �
� 
ledg
~ 4  
��

� 
cpar
 l  
���
� [   
�
�
� o   �� 0 paracounter ParaCounter
� m  �� �  �  �  �  
z �
��
� 
rtyp
� m  �
� 
TEXT�  �   �  
w m  
�
� �
�
�  5 2 0 � p t
n r  *
�
�
� m  �
� boovfals
� n      
�
�
� 1  %)�
� 
kewn
� 4  %�
�
� 
cpar
� o  #$�� 0 paracounter ParaCounter�&  �%  
k 0 *Fix two incompatible paragraph styles --OK   
l �
�
� T F i x   t w o   i n c o m p a t i b l e   p a r a g r a p h   s t y l e s   - - O K
i R      ���
� .ascrerr ****      � ****�  �  �'  
g 
�
�
� l 88��
�	�  �
  �	  
� 
�
�
� Q  8h
�
��
� l ;_
�
�
�
� Z ;_
�
���
� F  ;L
�
�
� = ;@
�
�
� o  ;<�� 0 ssname SSName
� m  <?
�
� �
�
�  C o n f P t s 2
� = CH
�
�
� o  CD�� 0 ssnameplus1 SSNamePlus1
� m  DG
�
� �
�
� " B r e e d / C l a s s , S m a l l
� r  O[
�
�
� m  OP�
� boovfals
� n      
�
�
� 1  VZ�
� 
kewn
� 4  PV�
�
� 
cpar
� o  TU� �  0 paracounter ParaCounter�  �  
� 0 *Fix two incompatible paragraph styles --OK   
� �
�
� T F i x   t w o   i n c o m p a t i b l e   p a r a g r a p h   s t y l e s   - - O K
� R      ������
�� .ascrerr ****      � ****��  ��  �  
� 
�
�
� l ii��������  ��  ��  
� 
�
�
� Q  i�
�
���
� l l�
�
�
�
� Z l�
�
�����
� F  l}
�
�
� = lq
�
�
� o  lm���� 0 ssname SSName
� m  mp
�
� �
�
�  C o m b O b e d P t s
� = ty
�
�
� o  tu���� 0 ssnameplus1 SSNamePlus1
� m  ux
�
� �
�
�  C o m b O b e d P t s
� r  ��
�
�
� m  ����
�� boovtrue
� n      
�
�
� 1  ����
�� 
kewn
� 4  ����
�
�� 
cpar
� o  ������ 0 paracounter ParaCounter��  ��  
� - 'Lock two paragraph styles together --OK   
� �
�
� N L o c k   t w o   p a r a g r a p h   s t y l e s   t o g e t h e r   - - O K
� R      ������
�� .ascrerr ****      � ****��  ��  ��  
� 
�
�
� l ����������  ��  ��  
� 
�
�
� l ����
�
���  
� V PThis was causing breeds with sweeptakes to not have page number in breed indexer   
� �
�
� � T h i s   w a s   c a u s i n g   b r e e d s   w i t h   s w e e p t a k e s   t o   n o t   h a v e   p a g e   n u m b e r   i n   b r e e d   i n d e x e r
� 
�
�
� l  ����
�
���  
�"try --Make breed header in single specialties larger and start on new page --OK
         if CatType is "Single" and SSName is "Breed/Class,Large" and SSNamePlus1 is "ClassType" then set paragraph style of paragraph ParaCounter to "Class" --and ShowType is "Specialty"
         end try   
� �
�
�8 t r y   - - M a k e   b r e e d   h e a d e r   i n   s i n g l e   s p e c i a l t i e s   l a r g e r   a n d   s t a r t   o n   n e w   p a g e   - - O K 
                   i f   C a t T y p e   i s   " S i n g l e "   a n d   S S N a m e   i s   " B r e e d / C l a s s , L a r g e "   a n d   S S N a m e P l u s 1   i s   " C l a s s T y p e "   t h e n   s e t   p a r a g r a p h   s t y l e   o f   p a r a g r a p h   P a r a C o u n t e r   t o   " C l a s s "   - - a n d   S h o w T y p e   i s   " S p e c i a l t y " 
                   e n d   t r y
� 
�
�
� l ����������  ��  ��  
� 
�
�
� Q  ��
�
���
� l ��
�
�
�
� Z ��
�
�����
� = ��
�
�
� o  ������ 0 ssname SSName
� m  ��
�
� �
�
�  H e a d e r
� r  ��
�
�
� m  ����
�� boovfals
� n      
�
�
� 1  ����
�� 
kewn
� 4  ����
�
�� 
cpar
� l ��
�����
� \  ��
�
�
� o  ������ 0 paracounter ParaCounter
� m  ������ ��  ��  ��  ��  
� @ :Turn off Keep with Next for line before Junior Show header   
� �
�
� t T u r n   o f f   K e e p   w i t h   N e x t   f o r   l i n e   b e f o r e   J u n i o r   S h o w   h e a d e r
� R      ������
�� .ascrerr ****      � ****��  ��  ��  
� 
�
�
� l ����������  ��  ��  
� 
�
�
� Q  ��
�
���
� l ��
�
�
�
� Z ��
�
�����
� F  ��
�
�
� = ��
�
�
� o  ������ 0 ssname SSName
� m  ��
�
� �
�
�  E n t r y L a s t
� = ��
�
�
� o  ������ 0 ssnameplus1 SSNamePlus1
� o  ������ 0 	entrylast 	EntryLast
� r  ��
�
�
� m  ��
�
� �
�
� 
 E n t r y
� n      
�
�
� 1  ����
�� 
PRSS
� 4  ����
�
�� 
cpar
� o  ������ 0 paracounter ParaCounter��  ��  
� 8 2Make sure two EntryLast paragraphs aren't together   
� �   d M a k e   s u r e   t w o   E n t r y L a s t   p a r a g r a p h s   a r e n ' t   t o g e t h e r
� R      ������
�� .ascrerr ****      � ****��  ��  ��  
�  l ����������  ��  ��    Q  �7�� l �.	 Z �.
����
 F  �  C  �� o  ������ 0 ssname SSName m  �� � 
 E n t r y = � n  � 4  ��
�� 
cobj m  ����  n  � 1  ��
�� 
onst l ����� e  � n  � 1  
��
�� 
txst n  �
 4  
��
�� 
cha  m  	������ 4  ��� 
�� 
cpar  o  ���� 0 paracounter ParaCounter��  ��   m  ��
�� stylbold r  #*!"! m  #&## �$$  Y e s" o      ���� 0 needexbindex NeedExbIndex��  ��   < 6Check to see if catalog needs Index to Exhibitors --OK   	 �%% l C h e c k   t o   s e e   i f   c a t a l o g   n e e d s   I n d e x   t o   E x h i b i t o r s   - - O K R      ������
�� .ascrerr ****      � ****��  ��  ��   &'& l 88��������  ��  ��  ' ()( Q  8	*+��* l ; ,-., k  ; // 010 l ;;��23��  2  Find judge line   3 �44  F i n d   j u d g e   l i n e1 5��5 Z  ; 67����6 = ;B898 o  ;>���� "0 checkringstimes CheckRingsTimes9 m  >A:: �;;  Y e s7 Z  E�<=����< = EJ>?> o  EF���� 0 ssname SSName? m  FI@@ �AA 
 J u d g e= k  M�BB CDC l MM��EF��  E = 7Check to see if paragraph style of next line is correct   F �GG n C h e c k   t o   s e e   i f   p a r a g r a p h   s t y l e   o f   n e x t   l i n e   i s   c o r r e c tD H��H Z  M�IJ����I > MRKLK o  MN���� 0 ssnameplus1 SSNamePlus1L m  NQMM �NN  R i n g / T i m eJ k  U�OO PQP l UU��RS��  R A ;Check to see if paragraph style of previous line is correct   S �TT v C h e c k   t o   s e e   i f   p a r a g r a p h   s t y l e   o f   p r e v i o u s   l i n e   i s   c o r r e c tQ U��U Y  U�V��WX��V k  a�YY Z[Z l aa��\]��  \ C =Convert name of paragraph style to text for faster processing   ] �^^ z C o n v e r t   n a m e   o f   p a r a g r a p h   s t y l e   t o   t e x t   f o r   f a s t e r   p r o c e s s i n g[ _`_ r  asaba n  aqcdc 1  mq��
�� 
pnamd n  amefe 1  im��
�� 
PRSSf 4  ai��g
�� 
cparg l ehh����h \  ehiji o  ef���� 0 paracounter ParaCounterj o  fg���� 0 ringcounter RingCounter��  ��  b o      ���� 0 
ringssname 
RingSSName` k��k Z  t�lm����l G  t�non l t�p����p F  t�qrq F  t�sts l tyu����u = tyvwv o  tu���� 0 
ringssname 
RingSSNamew m  uxxx �yy " B r e e d / C l a s s , L a r g e��  ��  t l |�z����z H  |�{{ E  |�|}| 4  |���~
�� 
cpar~ l ������ \  ����� o  ������ 0 paracounter ParaCounter� o  ������ 0 ringcounter RingCounter��  ��  } m  ���� ���  a g i l i t y��  ��  r l �������� H  ���� E  ����� 4  �����
�� 
cpar� l �������� \  ����� o  ������ 0 paracounter ParaCounter� o  ���� 0 ringcounter RingCounter��  ��  � m  ���� ���  j u m p e r s��  ��  ��  ��  o l ����~�}� = ����� o  ���|�| 0 
ringssname 
RingSSName� m  ���� ��� 
 G r o u p�~  �}  m k  ���� ��� l ���{���{  � J DIf ring/time is missing, get the judge's name and the breed or group   � ��� � I f   r i n g / t i m e   i s   m i s s i n g ,   g e t   t h e   j u d g e ' s   n a m e   a n d   t h e   b r e e d   o r   g r o u p� ��� r  ����� b  ����� b  ����� o  ���z�z 0 
judgeerror 
JudgeError� o  ���y
�y 
ret � l ����x�w� b  ����� b  ����� b  ����� b  ����� l ����v�u� c  ����� l ����t�s� n  ����� 7���r��
�r 
cha � m  ���q�q � m  ���p�p��� 4  ���o�
�o 
cpar� o  ���n�n 0 paracounter ParaCounter�t  �s  � m  ���m
�m 
ctxt�v  �u  � m  ���� ��� 0   m a y   h a v e   a n   e r r o r   w i t h  � o  ���l
�l 
ret � l ����k�j� 4  ���i�
�i 
cpar� l ����h�g� \  ����� o  ���f�f 0 paracounter ParaCounter� o  ���e�e 0 ringcounter RingCounter�h  �g  �k  �j  � o  ���d
�d 
ret �x  �w  � o      �c�c 0 
judgeerror 
JudgeError� ��b�  S  ���b  ��  ��  ��  �� 0 ringcounter RingCounterW m  XY�a�a X m  Y\�`�` ��  ��  ��  ��  ��  ��  ��  ��  ��  ��  - . (Make sure the rings/times are there --OK   . ��� P M a k e   s u r e   t h e   r i n g s / t i m e s   a r e   t h e r e   - - O K+ R      �_�^�]
�_ .ascrerr ****      � ****�^  �]  ��  ) ��� l 

�\�[�Z�\  �[  �Z  � ��� Q  
���Y� l �X�W�V�X  �W  �V  � R      �U�T�S
�U .ascrerr ****      � ****�T  �S  �Y  � ��� l �R�Q�P�R  �Q  �P  � ��� Q  )���O� l  ���� Z   ���N�M� = "��� o  �L�L  0 getjudgereport GetJudgeReport� m  !�� ���  Y e s� Z  %���K�J� G  %l��� l %*��I�H� = %*��� o  %&�G�G 0 ssname SSName� m  &)�� ��� " B r e e d / C l a s s , L a r g e�I  �H  � l -h��F�E� F  -h��� F  -V��� F  -D��� l -2��D�C� = -2��� o  -.�B�B 0 ssname SSName� m  .1�� ��� 
 G r o u p�D  �C  � l 5@��A�@� H  5@�� E  5?��� 4  5;�?�
�? 
cpar� o  9:�>�> 0 paracounter ParaCounter� m  ;>�� ���  b r e e d s�A  �@  � l GR��=�<� H  GR�� E  GQ��� 4  GM�;�
�; 
cpar� o  KL�:�: 0 paracounter ParaCounter� m  MP�� ��� 
 i n d e x�=  �<  � l Yd��9�8� H  Yd�� E  Yc��� 4  Y_�7�
�7 
cpar� o  ]^�6�6 0 paracounter ParaCounter� m  _b�� ��� " o b e d i e n c e   e n t r i e s�9  �8  �F  �E  � k  o�� ��� l oo�5���5  � - 'When set to 1, will get breed and judge   � �   N W h e n   s e t   t o   1 ,   w i l l   g e t   b r e e d   a n d   j u d g e�  r  or m  op�4�4  o      �3�3 0 newbreedtest NewBreedTest  l ss�2�2   E ?Check to see if any of 5 paragraphs after breed is a judge line    �		 ~ C h e c k   t o   s e e   i f   a n y   o f   5   p a r a g r a p h s   a f t e r   b r e e d   i s   a   j u d g e   l i n e 
�1
 Y  s�0�/ k    l �.�.   C =Convert name of paragraph style to text for faster processing    � z C o n v e r t   n a m e   o f   p a r a g r a p h   s t y l e   t o   t e x t   f o r   f a s t e r   p r o c e s s i n g  r  � n  � 1  ���-
�- 
pnam n  � 1  ���,
�, 
PRSS 4  ��+
�+ 
cpar l ���*�) [  �� o  ���(�( 0 paracounter ParaCounter o  ���'�' 0 judgecounter JudgeCounter�*  �)   o      �&�& 0 judgessname JudgeSSName  �%  Z  �!"#�$! = ��$%$ o  ���#�# 0 judgessname JudgeSSName% m  ��&& �'' 
 J u d g e" k  ��(( )*) l ���"+,�"  + $ Get breed if NewBreedTest is 1   , �-- < G e t   b r e e d   i f   N e w B r e e d T e s t   i s   1* ./. Z ��01�!� 0 = ��232 o  ���� 0 newbreedtest NewBreedTest3 m  ���� 1 r  ��454 b  ��676 b  ��898 b  ��:;: o  ���� 0 	judgelist 	JudgeList; o  ���
� 
ret 9 o  ���
� 
ret 7 l ��<��< c  ��=>= l ��?��? n  ��@A@ 7���BC
� 
cha B m  ���� C m  ������A 4  ���D
� 
cparD o  ���� 0 paracounter ParaCounter�  �  > m  ���
� 
ctxt�  �  5 o      �� 0 	judgelist 	JudgeList�!  �   / EFE l ���GH�  G  	Get judge   H �II  G e t   j u d g eF JKJ r  ��LML l ��N��N b  ��OPO b  ��QRQ o  ���� 0 	judgelist 	JudgeListR o  ���
� 
ret P l ��S�
�	S c  ��TUT l ��V��V n  ��WXW 7���YZ
� 
cha Y m  ���� Z m  ������X 4  ���[
� 
cpar[ l ��\��\ [  ��]^] o  ��� �  0 paracounter ParaCounter^ o  ������ 0 judgecounter JudgeCounter�  �  �  �  U m  ����
�� 
ctxt�
  �	  �  �  M o      ���� 0 	judgelist 	JudgeListK _`_ l ����ab��  a ( "When set to 0, will get only judge   b �cc D W h e n   s e t   t o   0 ,   w i l l   g e t   o n l y   j u d g e` d��d r  ��efe m  ������  f o      ���� 0 newbreedtest NewBreedTest��  # ghg F  �iji > ��klk o  ������ 0 judgessname JudgeSSNamel m  ��mm �nn  R i n g / T i m ej > opo o  ���� 0 judgessname JudgeSSNamep m  qq �rr  C l a s s T y p eh s��s  S  ��  �$  �%  �0 0 judgecounter JudgeCounter m  vw����  m  wz���� �/  �1  �K  �J  �N  �M  � ! Get the list of judges --OK   � �tt 6 G e t   t h e   l i s t   o f   j u d g e s   - - O K� R      ������
�� .ascrerr ****      � ****��  ��  �O  � uvu l **��������  ��  ��  v wxw l  **��yz��  y"5"/)--Format the Agility section, if present
         if (SSName is "Breed/Class,Large") and ((paragraph ParaCounter contains "agility") or (paragraph ParaCounter contains "jumpers")) and (name of color of paragraph ParaCounter is not "blue") then
         
         --Set some variables
         set AgilityHeader to "xxxxxxxx"
         set AgilityFlag to false
         set AgilityCounter to (ParaCounter - 1)
         
         --Repeat once for each paragraph
         repeat until AgilityFlag is true
         
         --Advance the counter
         set AgilityCounter to AgilityCounter + 1
         
         --Convert paragraph style name to text for quicker checking
         set AgilSSName to name of paragraph style of paragraph AgilityCounter
         
         --Do this only if paragraph is an Agility header
         if (AgilSSName is "Breed/Class,Large") and ((paragraph AgilityCounter contains "agility") or (paragraph AgilityCounter contains "jumpers")) then
         
         --If it's a new Agility header, then do these lines
         if paragraph AgilityCounter does not contain AgilityHeader then
         
         --Repeat 7 times to move up to 7 ring/times
         repeat with RingCounter from 1 to 7
         
         --Check to see if this is a ring/time line
         if name of paragraph style of paragraph (AgilityCounter + RingCounter) is "Ring/Time" then
         --Delete the ring/time line
         delete paragraph (AgilityCounter + RingCounter)
         --Subtract a paragraph from the ParaCount
         set ParaCount to ParaCount - 1
         end if
         
         end repeat
         
         --Repeat 7 times to move up to 7 judges
         repeat with JudgeCounter from 1 to 7
         
         --Check to see if this is a Judge line
         if name of paragraph style of paragraph (AgilityCounter + JudgeCounter) is "Judge" then
         --Move the Judge line to above the Agility Size line
         move paragraph (AgilityCounter + JudgeCounter) to before paragraph ((AgilityCounter + JudgeCounter) - 1)
         end if
         
         end repeat
         
         --Make a note of what the Agility header is, so that similar following Agility headers will be deleted
         set AgilityHeader to paragraph AgilityCounter
         
         else --Do these lines for each subsequent Agility header
         
         --Do this until all judges lines are deleted
         repeat until paragraph (AgilityCounter + 2) does not contain "Judge" and name of paragraph style of paragraph (AgilityCounter + 2) is not "Ring/Time"
         --Delete the judge line
         delete paragraph (AgilityCounter + 2)
         --Subtract a paragraph from the ParaCount
         set ParaCount to ParaCount - 1
         end repeat
         
         --Delete the Agility line
         delete paragraph AgilityCounter
         
         end if
         
         end if
         
         --Do these lines for Agility entries
         if AgilSSName starts with "entry" then
         
         --Change paragraph style to AgilityEntry, which keeps with next paragraph and indents an extra pica
         set paragraph style of paragraph AgilityCounter to "AgilityEntry"
         
         --Only do this for multiple shows
         if GroupFileCount � 1 then
         
         --Lock the Agility entry to the next line
         set keep with next of paragraph AgilityCounter to true
         --Make a blank paragraph to place each day/score line
         copy return to after paragraph AgilityCounter
         --Add a paragraph to the ParaCount
         set ParaCount to ParaCount + 1
         --Set the paragraph style of the blank day/score line
         set paragraph style of paragraph (AgilityCounter + 1) to "AgilityScore"
         --If next paragraph is a points line, then lock them together
         if name of paragraph style of paragraph (AgilityCounter + 2) is "CombObedPts" then set keep with next of paragraph (AgilityCounter + 1) to true
         
         --Repeat for each of the first 10 characters of the entry
         repeat with CharCounter from 1 to 10
         --Check to see if the character is a special Align Here character
         if (ASCII number ((character CharCounter of paragraph AgilityCounter) as text)) is 30 then
         --Get the location of this character, which is the day/score line to be moved
         set DayStart to (offset of character CharCounter of paragraph AgilityCounter) + 2
         exit repeat
         end if
         end repeat
         
         --Repeat up to seven times, once for each day of the week
         repeat with DayCounter from 1 to 7
         --Place a soft return after the second, fourth, and sixth day
         if DayCounter mod 2 is 1 and DayCounter > 1 then copy (ASCII character 7) to before character -1 of paragraph (AgilityCounter + 1)
         --Get the day/score text
         set DayText to (text from character DayStart to character (DayStart + 7))
         
         --If day/score text is a day of the week, then do these lines
         if {"TUE____	", "MON____	", "SUN____	", "SAT____	", "FRI____	", "THU____	", "WED____	"} contains DayText then
         --Delete the day/score line from the entry
         delete (first text of paragraph AgilityCounter whose it is DayText)
         --Create the day/score text and place it on the day/score line after the entry
         copy tab & ((characters 1 through 3 of DayText) as text) & ":	Score:______ 	Time:______" to before character -1 of paragraph (AgilityCounter + 1)
         --If the day/score text is blank (no entry for that day), then do these lines
         else if DayText is "       	" then
         --Delete the blank day/score text from the entry
         delete (first text of paragraph AgilityCounter whose it is DayText)
         --Create a blank day/score text and place it on the day/score line after the entry
         copy tab & DayText & tab to before character -1 of paragraph (AgilityCounter + 1)
         else --After all days are removed from entry, then delete the last soft return, which is not needed
         delete character -2 of paragraph (AgilityCounter + 1)
         --No more days in entry, so exit the loop
         exit repeat
         end if
         
         end repeat
         
         end if
         
         --Place the inch division before the entry number
         if paragraph AgilityCounter is not "" then copy InchText & "-" to before character 1 of paragraph AgilityCounter
         
         --If the paragraph is the inches division, then do these lines
         else if (AgilSSName is "Breed/Class,Large") and ((paragraph AgilityCounter contains "inches") or (paragraph AgilityCounter contains "Maxi") or (paragraph AgilityCounter contains "Mini")) then
         --Place the points line after the Agility Size header
         set after paragraph AgilityCounter to "SCT______               YDS______" & return
         --Add a paragraph to the ParaCount
         set ParaCount to ParaCount + 1
         --Format the points line
         set paragraph style of paragraph (AgilityCounter + 1) to "AgilitySCT"
         --Delete the erroneous space before the inch division
         if character 1 of paragraph AgilityCounter is " " then delete character 1 of paragraph AgilityCounter
         --Get the Inches to place before the entry number
         set InchText to ((characters 1 through 2 of paragraph AgilityCounter) as text)
         if InchText is "8 " then
         set InchText to "8"
         else if InchText is "Ma" then
         set InchText to "MA"
         else if InchText is "Mi" then
         set InchText to "MI"
         end if
         
         --Done with this inches division, so exit the loop
         else if (AgilSSName is "ShowName") or ((count of characters of paragraph AgilityCounter) is 0) or ((AgilSSName is "Breed/Class,Large") and (paragraph AgilityCounter does not contain "agility") and (paragraph AgilityCounter does not contain "jumpers") and (paragraph AgilityCounter does not contain "inches") and (paragraph AgilityCounter does not contain "Maxi") and (paragraph AgilityCounter does not contain "Mini")) then
         set AgilityFlag to true
         
         end if
         
         end repeat
         
         --Change the color to blue, so the Agility check won't be triggered
         set color of (paragraphs ParaCounter through (AgilityCounter - 2)) to "blue"
         
         --Start checking paragraphs following the Agility section
         set ParaCounter to (AgilityCounter - 2)
         
         --Subtract the Agility paragraphs from the ParaCount
         set ParaCount to (counter - (count of (paragraphs whose name of color is "blue")))
         
         end if   z �{{D^ ) - - F o r m a t   t h e   A g i l i t y   s e c t i o n ,   i f   p r e s e n t 
                   i f   ( S S N a m e   i s   " B r e e d / C l a s s , L a r g e " )   a n d   ( ( p a r a g r a p h   P a r a C o u n t e r   c o n t a i n s   " a g i l i t y " )   o r   ( p a r a g r a p h   P a r a C o u n t e r   c o n t a i n s   " j u m p e r s " ) )   a n d   ( n a m e   o f   c o l o r   o f   p a r a g r a p h   P a r a C o u n t e r   i s   n o t   " b l u e " )   t h e n 
                   
                   - - S e t   s o m e   v a r i a b l e s 
                   s e t   A g i l i t y H e a d e r   t o   " x x x x x x x x " 
                   s e t   A g i l i t y F l a g   t o   f a l s e 
                   s e t   A g i l i t y C o u n t e r   t o   ( P a r a C o u n t e r   -   1 ) 
                   
                   - - R e p e a t   o n c e   f o r   e a c h   p a r a g r a p h 
                   r e p e a t   u n t i l   A g i l i t y F l a g   i s   t r u e 
                   
                   - - A d v a n c e   t h e   c o u n t e r 
                   s e t   A g i l i t y C o u n t e r   t o   A g i l i t y C o u n t e r   +   1 
                   
                   - - C o n v e r t   p a r a g r a p h   s t y l e   n a m e   t o   t e x t   f o r   q u i c k e r   c h e c k i n g 
                   s e t   A g i l S S N a m e   t o   n a m e   o f   p a r a g r a p h   s t y l e   o f   p a r a g r a p h   A g i l i t y C o u n t e r 
                   
                   - - D o   t h i s   o n l y   i f   p a r a g r a p h   i s   a n   A g i l i t y   h e a d e r 
                   i f   ( A g i l S S N a m e   i s   " B r e e d / C l a s s , L a r g e " )   a n d   ( ( p a r a g r a p h   A g i l i t y C o u n t e r   c o n t a i n s   " a g i l i t y " )   o r   ( p a r a g r a p h   A g i l i t y C o u n t e r   c o n t a i n s   " j u m p e r s " ) )   t h e n 
                   
                   - - I f   i t ' s   a   n e w   A g i l i t y   h e a d e r ,   t h e n   d o   t h e s e   l i n e s 
                   i f   p a r a g r a p h   A g i l i t y C o u n t e r   d o e s   n o t   c o n t a i n   A g i l i t y H e a d e r   t h e n 
                   
                   - - R e p e a t   7   t i m e s   t o   m o v e   u p   t o   7   r i n g / t i m e s 
                   r e p e a t   w i t h   R i n g C o u n t e r   f r o m   1   t o   7 
                   
                   - - C h e c k   t o   s e e   i f   t h i s   i s   a   r i n g / t i m e   l i n e 
                   i f   n a m e   o f   p a r a g r a p h   s t y l e   o f   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   R i n g C o u n t e r )   i s   " R i n g / T i m e "   t h e n 
                   - - D e l e t e   t h e   r i n g / t i m e   l i n e 
                   d e l e t e   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   R i n g C o u n t e r ) 
                   - - S u b t r a c t   a   p a r a g r a p h   f r o m   t h e   P a r a C o u n t 
                   s e t   P a r a C o u n t   t o   P a r a C o u n t   -   1 
                   e n d   i f 
                   
                   e n d   r e p e a t 
                   
                   - - R e p e a t   7   t i m e s   t o   m o v e   u p   t o   7   j u d g e s 
                   r e p e a t   w i t h   J u d g e C o u n t e r   f r o m   1   t o   7 
                   
                   - - C h e c k   t o   s e e   i f   t h i s   i s   a   J u d g e   l i n e 
                   i f   n a m e   o f   p a r a g r a p h   s t y l e   o f   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   J u d g e C o u n t e r )   i s   " J u d g e "   t h e n 
                   - - M o v e   t h e   J u d g e   l i n e   t o   a b o v e   t h e   A g i l i t y   S i z e   l i n e 
                   m o v e   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   J u d g e C o u n t e r )   t o   b e f o r e   p a r a g r a p h   ( ( A g i l i t y C o u n t e r   +   J u d g e C o u n t e r )   -   1 ) 
                   e n d   i f 
                   
                   e n d   r e p e a t 
                   
                   - - M a k e   a   n o t e   o f   w h a t   t h e   A g i l i t y   h e a d e r   i s ,   s o   t h a t   s i m i l a r   f o l l o w i n g   A g i l i t y   h e a d e r s   w i l l   b e   d e l e t e d 
                   s e t   A g i l i t y H e a d e r   t o   p a r a g r a p h   A g i l i t y C o u n t e r 
                   
                   e l s e   - - D o   t h e s e   l i n e s   f o r   e a c h   s u b s e q u e n t   A g i l i t y   h e a d e r 
                   
                   - - D o   t h i s   u n t i l   a l l   j u d g e s   l i n e s   a r e   d e l e t e d 
                   r e p e a t   u n t i l   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   2 )   d o e s   n o t   c o n t a i n   " J u d g e "   a n d   n a m e   o f   p a r a g r a p h   s t y l e   o f   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   2 )   i s   n o t   " R i n g / T i m e " 
                   - - D e l e t e   t h e   j u d g e   l i n e 
                   d e l e t e   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   2 ) 
                   - - S u b t r a c t   a   p a r a g r a p h   f r o m   t h e   P a r a C o u n t 
                   s e t   P a r a C o u n t   t o   P a r a C o u n t   -   1 
                   e n d   r e p e a t 
                   
                   - - D e l e t e   t h e   A g i l i t y   l i n e 
                   d e l e t e   p a r a g r a p h   A g i l i t y C o u n t e r 
                   
                   e n d   i f 
                   
                   e n d   i f 
                   
                   - - D o   t h e s e   l i n e s   f o r   A g i l i t y   e n t r i e s 
                   i f   A g i l S S N a m e   s t a r t s   w i t h   " e n t r y "   t h e n 
                   
                   - - C h a n g e   p a r a g r a p h   s t y l e   t o   A g i l i t y E n t r y ,   w h i c h   k e e p s   w i t h   n e x t   p a r a g r a p h   a n d   i n d e n t s   a n   e x t r a   p i c a 
                   s e t   p a r a g r a p h   s t y l e   o f   p a r a g r a p h   A g i l i t y C o u n t e r   t o   " A g i l i t y E n t r y " 
                   
                   - - O n l y   d o   t h i s   f o r   m u l t i p l e   s h o w s 
                   i f   G r o u p F i l e C o u n t  "`   1   t h e n 
                   
                   - - L o c k   t h e   A g i l i t y   e n t r y   t o   t h e   n e x t   l i n e 
                   s e t   k e e p   w i t h   n e x t   o f   p a r a g r a p h   A g i l i t y C o u n t e r   t o   t r u e 
                   - - M a k e   a   b l a n k   p a r a g r a p h   t o   p l a c e   e a c h   d a y / s c o r e   l i n e 
                   c o p y   r e t u r n   t o   a f t e r   p a r a g r a p h   A g i l i t y C o u n t e r 
                   - - A d d   a   p a r a g r a p h   t o   t h e   P a r a C o u n t 
                   s e t   P a r a C o u n t   t o   P a r a C o u n t   +   1 
                   - - S e t   t h e   p a r a g r a p h   s t y l e   o f   t h e   b l a n k   d a y / s c o r e   l i n e 
                   s e t   p a r a g r a p h   s t y l e   o f   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   1 )   t o   " A g i l i t y S c o r e " 
                   - - I f   n e x t   p a r a g r a p h   i s   a   p o i n t s   l i n e ,   t h e n   l o c k   t h e m   t o g e t h e r 
                   i f   n a m e   o f   p a r a g r a p h   s t y l e   o f   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   2 )   i s   " C o m b O b e d P t s "   t h e n   s e t   k e e p   w i t h   n e x t   o f   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   1 )   t o   t r u e 
                   
                   - - R e p e a t   f o r   e a c h   o f   t h e   f i r s t   1 0   c h a r a c t e r s   o f   t h e   e n t r y 
                   r e p e a t   w i t h   C h a r C o u n t e r   f r o m   1   t o   1 0 
                   - - C h e c k   t o   s e e   i f   t h e   c h a r a c t e r   i s   a   s p e c i a l   A l i g n   H e r e   c h a r a c t e r 
                   i f   ( A S C I I   n u m b e r   ( ( c h a r a c t e r   C h a r C o u n t e r   o f   p a r a g r a p h   A g i l i t y C o u n t e r )   a s   t e x t ) )   i s   3 0   t h e n 
                   - - G e t   t h e   l o c a t i o n   o f   t h i s   c h a r a c t e r ,   w h i c h   i s   t h e   d a y / s c o r e   l i n e   t o   b e   m o v e d 
                   s e t   D a y S t a r t   t o   ( o f f s e t   o f   c h a r a c t e r   C h a r C o u n t e r   o f   p a r a g r a p h   A g i l i t y C o u n t e r )   +   2 
                   e x i t   r e p e a t 
                   e n d   i f 
                   e n d   r e p e a t 
                   
                   - - R e p e a t   u p   t o   s e v e n   t i m e s ,   o n c e   f o r   e a c h   d a y   o f   t h e   w e e k 
                   r e p e a t   w i t h   D a y C o u n t e r   f r o m   1   t o   7 
                   - - P l a c e   a   s o f t   r e t u r n   a f t e r   t h e   s e c o n d ,   f o u r t h ,   a n d   s i x t h   d a y 
                   i f   D a y C o u n t e r   m o d   2   i s   1   a n d   D a y C o u n t e r   >   1   t h e n   c o p y   ( A S C I I   c h a r a c t e r   7 )   t o   b e f o r e   c h a r a c t e r   - 1   o f   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   1 ) 
                   - - G e t   t h e   d a y / s c o r e   t e x t 
                   s e t   D a y T e x t   t o   ( t e x t   f r o m   c h a r a c t e r   D a y S t a r t   t o   c h a r a c t e r   ( D a y S t a r t   +   7 ) ) 
                   
                   - - I f   d a y / s c o r e   t e x t   i s   a   d a y   o f   t h e   w e e k ,   t h e n   d o   t h e s e   l i n e s 
                   i f   { " T U E _ _ _ _ 	 " ,   " M O N _ _ _ _ 	 " ,   " S U N _ _ _ _ 	 " ,   " S A T _ _ _ _ 	 " ,   " F R I _ _ _ _ 	 " ,   " T H U _ _ _ _ 	 " ,   " W E D _ _ _ _ 	 " }   c o n t a i n s   D a y T e x t   t h e n 
                   - - D e l e t e   t h e   d a y / s c o r e   l i n e   f r o m   t h e   e n t r y 
                   d e l e t e   ( f i r s t   t e x t   o f   p a r a g r a p h   A g i l i t y C o u n t e r   w h o s e   i t   i s   D a y T e x t ) 
                   - - C r e a t e   t h e   d a y / s c o r e   t e x t   a n d   p l a c e   i t   o n   t h e   d a y / s c o r e   l i n e   a f t e r   t h e   e n t r y 
                   c o p y   t a b   &   ( ( c h a r a c t e r s   1   t h r o u g h   3   o f   D a y T e x t )   a s   t e x t )   &   " : 	 S c o r e : _ _ _ _ _ _   	 T i m e : _ _ _ _ _ _ "   t o   b e f o r e   c h a r a c t e r   - 1   o f   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   1 ) 
                   - - I f   t h e   d a y / s c o r e   t e x t   i s   b l a n k   ( n o   e n t r y   f o r   t h a t   d a y ) ,   t h e n   d o   t h e s e   l i n e s 
                   e l s e   i f   D a y T e x t   i s   "               	 "   t h e n 
                   - - D e l e t e   t h e   b l a n k   d a y / s c o r e   t e x t   f r o m   t h e   e n t r y 
                   d e l e t e   ( f i r s t   t e x t   o f   p a r a g r a p h   A g i l i t y C o u n t e r   w h o s e   i t   i s   D a y T e x t ) 
                   - - C r e a t e   a   b l a n k   d a y / s c o r e   t e x t   a n d   p l a c e   i t   o n   t h e   d a y / s c o r e   l i n e   a f t e r   t h e   e n t r y 
                   c o p y   t a b   &   D a y T e x t   &   t a b   t o   b e f o r e   c h a r a c t e r   - 1   o f   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   1 ) 
                   e l s e   - - A f t e r   a l l   d a y s   a r e   r e m o v e d   f r o m   e n t r y ,   t h e n   d e l e t e   t h e   l a s t   s o f t   r e t u r n ,   w h i c h   i s   n o t   n e e d e d 
                   d e l e t e   c h a r a c t e r   - 2   o f   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   1 ) 
                   - - N o   m o r e   d a y s   i n   e n t r y ,   s o   e x i t   t h e   l o o p 
                   e x i t   r e p e a t 
                   e n d   i f 
                   
                   e n d   r e p e a t 
                   
                   e n d   i f 
                   
                   - - P l a c e   t h e   i n c h   d i v i s i o n   b e f o r e   t h e   e n t r y   n u m b e r 
                   i f   p a r a g r a p h   A g i l i t y C o u n t e r   i s   n o t   " "   t h e n   c o p y   I n c h T e x t   &   " - "   t o   b e f o r e   c h a r a c t e r   1   o f   p a r a g r a p h   A g i l i t y C o u n t e r 
                   
                   - - I f   t h e   p a r a g r a p h   i s   t h e   i n c h e s   d i v i s i o n ,   t h e n   d o   t h e s e   l i n e s 
                   e l s e   i f   ( A g i l S S N a m e   i s   " B r e e d / C l a s s , L a r g e " )   a n d   ( ( p a r a g r a p h   A g i l i t y C o u n t e r   c o n t a i n s   " i n c h e s " )   o r   ( p a r a g r a p h   A g i l i t y C o u n t e r   c o n t a i n s   " M a x i " )   o r   ( p a r a g r a p h   A g i l i t y C o u n t e r   c o n t a i n s   " M i n i " ) )   t h e n 
                   - - P l a c e   t h e   p o i n t s   l i n e   a f t e r   t h e   A g i l i t y   S i z e   h e a d e r 
                   s e t   a f t e r   p a r a g r a p h   A g i l i t y C o u n t e r   t o   " S C T _ _ _ _ _ _                               Y D S _ _ _ _ _ _ "   &   r e t u r n 
                   - - A d d   a   p a r a g r a p h   t o   t h e   P a r a C o u n t 
                   s e t   P a r a C o u n t   t o   P a r a C o u n t   +   1 
                   - - F o r m a t   t h e   p o i n t s   l i n e 
                   s e t   p a r a g r a p h   s t y l e   o f   p a r a g r a p h   ( A g i l i t y C o u n t e r   +   1 )   t o   " A g i l i t y S C T " 
                   - - D e l e t e   t h e   e r r o n e o u s   s p a c e   b e f o r e   t h e   i n c h   d i v i s i o n 
                   i f   c h a r a c t e r   1   o f   p a r a g r a p h   A g i l i t y C o u n t e r   i s   "   "   t h e n   d e l e t e   c h a r a c t e r   1   o f   p a r a g r a p h   A g i l i t y C o u n t e r 
                   - - G e t   t h e   I n c h e s   t o   p l a c e   b e f o r e   t h e   e n t r y   n u m b e r 
                   s e t   I n c h T e x t   t o   ( ( c h a r a c t e r s   1   t h r o u g h   2   o f   p a r a g r a p h   A g i l i t y C o u n t e r )   a s   t e x t ) 
                   i f   I n c h T e x t   i s   " 8   "   t h e n 
                   s e t   I n c h T e x t   t o   " 8 " 
                   e l s e   i f   I n c h T e x t   i s   " M a "   t h e n 
                   s e t   I n c h T e x t   t o   " M A " 
                   e l s e   i f   I n c h T e x t   i s   " M i "   t h e n 
                   s e t   I n c h T e x t   t o   " M I " 
                   e n d   i f 
                   
                   - - D o n e   w i t h   t h i s   i n c h e s   d i v i s i o n ,   s o   e x i t   t h e   l o o p 
                   e l s e   i f   ( A g i l S S N a m e   i s   " S h o w N a m e " )   o r   ( ( c o u n t   o f   c h a r a c t e r s   o f   p a r a g r a p h   A g i l i t y C o u n t e r )   i s   0 )   o r   ( ( A g i l S S N a m e   i s   " B r e e d / C l a s s , L a r g e " )   a n d   ( p a r a g r a p h   A g i l i t y C o u n t e r   d o e s   n o t   c o n t a i n   " a g i l i t y " )   a n d   ( p a r a g r a p h   A g i l i t y C o u n t e r   d o e s   n o t   c o n t a i n   " j u m p e r s " )   a n d   ( p a r a g r a p h   A g i l i t y C o u n t e r   d o e s   n o t   c o n t a i n   " i n c h e s " )   a n d   ( p a r a g r a p h   A g i l i t y C o u n t e r   d o e s   n o t   c o n t a i n   " M a x i " )   a n d   ( p a r a g r a p h   A g i l i t y C o u n t e r   d o e s   n o t   c o n t a i n   " M i n i " ) )   t h e n 
                   s e t   A g i l i t y F l a g   t o   t r u e 
                   
                   e n d   i f 
                   
                   e n d   r e p e a t 
                   
                   - - C h a n g e   t h e   c o l o r   t o   b l u e ,   s o   t h e   A g i l i t y   c h e c k   w o n ' t   b e   t r i g g e r e d 
                   s e t   c o l o r   o f   ( p a r a g r a p h s   P a r a C o u n t e r   t h r o u g h   ( A g i l i t y C o u n t e r   -   2 ) )   t o   " b l u e " 
                   
                   - - S t a r t   c h e c k i n g   p a r a g r a p h s   f o l l o w i n g   t h e   A g i l i t y   s e c t i o n 
                   s e t   P a r a C o u n t e r   t o   ( A g i l i t y C o u n t e r   -   2 ) 
                   
                   - - S u b t r a c t   t h e   A g i l i t y   p a r a g r a p h s   f r o m   t h e   P a r a C o u n t 
                   s e t   P a r a C o u n t   t o   ( c o u n t e r   -   ( c o u n t   o f   ( p a r a g r a p h s   w h o s e   n a m e   o f   c o l o r   i s   " b l u e " ) ) ) 
                   
                   e n d   i fx |��| l **��������  ��  ��  ��  
 n  
Y
f}~} 4  
a
f��
�� 
cflo m  
d
e���� ~ 4  
Y
a���
�� 
TXTB� m  
]
`�� ���  S t a r t B o x
 ��� l --��������  ��  ��  � ��� l --������  �  Update the ParaCount   � ��� ( U p d a t e   t h e   P a r a C o u n t� ��� r  -2��� \  -0��� o  -.���� 0 	paracount 	ParaCount� m  ./���� � o      ���� 0 	paracount 	ParaCount� ��� l 33��������  ��  ��  � ��� l 33������  � ( "Advance to the next paragraph --OK   � ��� D A d v a n c e   t o   t h e   n e x t   p a r a g r a p h   - - O K� ��� r  38��� [  36��� o  34���� 0 paracounter ParaCounter� m  45���� � o      ���� 0 paracounter ParaCounter� ���� l 99��������  ��  ��  ��  	� C =Everything in this repeat will check each line of the catalog   	� ��� z E v e r y t h i n g   i n   t h i s   r e p e a t   w i l l   c h e c k   e a c h   l i n e   o f   t h e   c a t a l o g	� ��� l @@��������  ��  ��  � ��� O  @E��� k  PD�� ��� l PP��������  ��  ��  � ��� l  PP������  �tell application "SKProgressBar"
 set header to "Fixing some individual paragraphs"
 tell progress bar
 increment by 1
 end tell
 end tell
 
 try --Change the Agility text back to black --OK
 set color of (every paragraph whose color is not "Black") to "Black"
 end try   � ��� t e l l   a p p l i c a t i o n   " S K P r o g r e s s B a r " 
   s e t   h e a d e r   t o   " F i x i n g   s o m e   i n d i v i d u a l   p a r a g r a p h s " 
   t e l l   p r o g r e s s   b a r 
   i n c r e m e n t   b y   1 
   e n d   t e l l 
   e n d   t e l l 
   
   t r y   - - C h a n g e   t h e   A g i l i t y   t e x t   b a c k   t o   b l a c k   - - O K 
   s e t   c o l o r   o f   ( e v e r y   p a r a g r a p h   w h o s e   c o l o r   i s   n o t   " B l a c k " )   t o   " B l a c k " 
   e n d   t r y� ��� l PP��������  ��  ��  � ��� O  Ps��� k  Vr�� ��� r  V_��� m  VY�� ��� B F i x i n g   s o m e   i n d i v i d u a l   p a r a g r a p h s� 1  Y^��
�� 
hEaR� ���� O  `r��� I hq�����
�� .pGbRIcRmnull���     ****��  � �����
�� 
bYVl� m  lm���� ��  � 1  `e��
�� 
cRpB��  � m  PS���                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  � ��� l tt��������  ��  ��  � ��� Q  t������ l w����� r  w���� m  wz�� ���  9 3 %� n      ��� 1  ����
�� 
phsc� l z������� 6 z���� 2  z��
�� 
cpar� F  ����� = ����� 1  ����
�� 
PRSS� m  ���� ��� " B r e e d / C l a s s , L a r g e� E  �����  g  ��� m  ���� ��� 4 ( B l e n h e i m   &   P r i n c e   C h a r l e s��  ��  � C =Change Blenheim & Prince Charles to 93% to fit on 1 line --OK   � ��� z C h a n g e   B l e n h e i m   &   P r i n c e   C h a r l e s   t o   9 3 %   t o   f i t   o n   1   l i n e   - - O K� R      ������
�� .ascrerr ****      � ****��  ��  ��  � ��� l ����������  ��  ��  � ��� O  ����� O  ����� I �������
�� .pGbRIcRmnull���     ****��  � �����
�� 
bYVl� m  ������ ��  � 1  ����
�� 
cRpB� m  �����                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  � ��� l ����������  ��  ��  � ��� Q  ������� l ������ Z ��������� = ����� o  ������ $0 deleteringstimes DeleteRingsTimes� m  ���� ���  Y e s� I �������
�� .coredeloobj        obj � l �������� 6 ����� 2  ����
�� 
cpar� = ����� 1  ����
�� 
PRSS� m  ���� ���  R i n g / T i m e��  ��  ��  ��  ��  � 8 2Delete all the ring/time lines in specialties --OK   � ��� d D e l e t e   a l l   t h e   r i n g / t i m e   l i n e s   i n   s p e c i a l t i e s   - - O K� R      ������
�� .ascrerr ****      � ****��  ��  ��  �    l ����������  ��  ��    O  � O  � I ����
�� .pGbRIcRmnull���     ****��   ��	��
�� 
bYVl	 m  ���� ��   1  ����
�� 
cRpB m  ��

�                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��    l ��������  ��  ��    Q  F�� l = O = I (<����
�� .coredeloobj        obj  l (8���� 6(8 2  (-��
�� 
ctxt = 07  g  11 m  26 �     ��  ��  ��   l %���� 6 %  2  ��
�� 
cpar  = $!"! 1  ��
�� 
PRSS" m  ### �$$  P o i n t S c a l e 2��  ��   7 1Delete extra spaces before numbers in PointScale2    �%% b D e l e t e   e x t r a   s p a c e s   b e f o r e   n u m b e r s   i n   P o i n t S c a l e 2 R      ������
�� .ascrerr ****      � ****��  ��  ��   &'& l GG��������  ��  ��  ' ()( O  G`*+* O  M_,-, I U^���.
�� .pGbRIcRmnull���     ****�  . �~/�}
�~ 
bYVl/ m  YZ�|�| �}  - 1  MR�{
�{ 
cRpB+ m  GJ00�                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  ) 121 l aa�z�y�x�z  �y  �x  2 343 Q  a�56�w5 l d�7897 Z d�:;�v�u: = di<=< o  de�t�t 0 docsize DocSize= m  eh>> �??  L a r g e   P r i n t; r  l�@A@ m  lo�s�s 	A 6 o�BCB n  oxDED 1  tx�r
�r 
ptszE 2  ot�q
�q 
cparC = {�FGF 1  |��p
�p 
PRSSG m  ��HH �II  P o i n t S c a l e 1�v  �u  8 = 7Change the size of PointScale1 for Large Print catalogs   9 �JJ n C h a n g e   t h e   s i z e   o f   P o i n t S c a l e 1   f o r   L a r g e   P r i n t   c a t a l o g s6 R      �o�n�m
�o .ascrerr ****      � ****�n  �m  �w  4 KLK l ���l�k�j�l  �k  �j  L MNM O  ��OPO O  ��QRQ I ���i�hS
�i .pGbRIcRmnull���     ****�h  S �gT�f
�g 
bYVlT m  ���e�e �f  R 1  ���d
�d 
cRpBP m  ��UU�                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  N VWV l ���c�b�a�c  �b  �a  W XYX Q  ��Z[�`Z l ��\]^\ Z ��_`�_�^_ = ��aba o  ���]�] "0 removekwnjudges RemoveKWNJudgesb m  ��cc �dd  Y e s` r  ��efe m  ���\
�\ boovfalsf n      ghg 1  ���[
�[ 
kewnh l ��i�Z�Yi 6 ��jkj 2  ���X
�X 
cpark = ��lml 1  ���W
�W 
PRSSm m  ��nn �oo 
 J u d g e�Z  �Y  �_  �^  ] g aIf box is checked, then let text break after judges to insert prizes, usually in specialties --OK   ^ �pp � I f   b o x   i s   c h e c k e d ,   t h e n   l e t   t e x t   b r e a k   a f t e r   j u d g e s   t o   i n s e r t   p r i z e s ,   u s u a l l y   i n   s p e c i a l t i e s   - - O K[ R      �V�U�T
�V .ascrerr ****      � ****�U  �T  �`  Y qrq l ���S�R�Q�S  �R  �Q  r sts O  ��uvu O  ��wxw I ���P�Oy
�P .pGbRIcRmnull���     ****�O  y �Nz�M
�N 
bYVlz m  ���L�L �M  x 1  ���K
�K 
cRpBv m  ��{{�                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  t |}| l ���J�I�H�J  �I  �H  } ~~ Q  �B���G� l 9���� Z 9���F�E� F  ��� = 	��� o  �D�D "0 checkringstimes CheckRingsTimes� m  �� ���  Y e s� > ��� o  �C�C 0 
judgeerror 
JudgeError� m  �� ���  � r  5��� b  %��� b  !��� o  �B
�B 
ret � o   �A
�A 
ret � o  !$�@�@ 0 
judgeerror 
JudgeError� n      ��� 8  04�?
�? 
insl� n  %0��� 4 +0�>�
�> 
cha � m  ./�=�=��� 4  %+�<�
�< 
cpar� m  )*�;�; �F  �E  � 8 2Insert the errors in the front of the catalog --OK   � ��� d I n s e r t   t h e   e r r o r s   i n   t h e   f r o n t   o f   t h e   c a t a l o g   - - O K� R      �:�9�8
�: .ascrerr ****      � ****�9  �8  �G   ��7� l CC�6�5�4�6  �5  �4  �7  � n  @M��� 4  HM�3�
�3 
cflo� m  KL�2�2 � 4  @H�1�
�1 
TXTB� m  DG�� ���  S t a r t B o x� ��0� l FF�/�.�-�/  �.  �-  �0  	� n  	�	���� 4  	�	��,�
�, 
page� m  	�	��+�+ � 4  	�	��*�
�* 
docu� o  	�	��)�) 0 docname DocName	� ��� l II�(�'�&�(  �'  �&  � ��� O  Ib��� O  Oa��� I W`�%�$�
�% .pGbRIcRmnull���     ****�$  � �#��"
�# 
bYVl� m  [\�!�! �"  � 1  OT� 
�  
cRpB� m  IL���                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  � ��� l cc����  �  �  � ��� Q  c����� l f����� Z f������ = fm��� o  fi�� $0 deleteringstimes DeleteRingsTimes� m  il�� ���  Y e s� r  p���� K  p}�� ���
� 
PAAT� K  s{�� ���
� 
spaf� m  vy�� ���  p 3�  �  � n      ��� 1  ���
� 
qpro� n  }���� 4  ����
� 
stsh� m  ���� ��� 
 J u d g e� 4  }���
� 
docu� o  ���� 0 docname DocName�  �  � E ?Fix space after of Judge lines if Rings/Times were deleted --OK   � ��� ~ F i x   s p a c e   a f t e r   o f   J u d g e   l i n e s   i f   R i n g s / T i m e s   w e r e   d e l e t e d   - - O K� R      ���
� .ascrerr ****      � ****�  �  �  � ��� l ������  �  �  � ��� O  ����� O  ����� I ���
�	�
�
 .pGbRIcRmnull���     ****�	  � ���
� 
bYVl� m  ���� �  � 1  ���
� 
cRpB� m  �����                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  � ��� l ������  �  �  � ��� Q  �<���� l ����� k  ��� ��� r  ����� m  ���
� boovfals� n      ��� 1  ��� 
�  
kewn� n  ����� 4  �����
�� 
cpar� m  ��������� n  ����� 4  �����
�� 
cflo� m  ������ � n  ����� 4  �����
�� 
TXTB� m  ���� ���  S t a r t B o x� n  ����� 4  �����
�� 
page� m  ������ � 4  �����
�� 
docu� o  ������ 0 docname DocName�  ��  r  � 4  ����
�� 
file o  ������ 0 
agentstext 
AgentsText n       9  	��
�� 
insl n  �	 4 	��
�� 
cha  m  ������ n  �	
	 4  ���
�� 
cflo m  ���� 
 n  �� 4  ����
�� 
TXTB m  �� �  S t a r t B o x n  �� 4  ����
�� 
page m  ������  4  ����
�� 
docu o  ������ 0 docname DocName��  � * $Import the Index to Agents text --OK   � � H I m p o r t   t h e   I n d e x   t o   A g e n t s   t e x t   - - O K� R      ������
�� .ascrerr ****      � ****��  ��  � l < t  < k  ;  I ������
�� .miscactvnull��� ��� null��  ��   �� I  ;�� 
�� .sysodlogaskr        TEXT m   #!! �"" � T h e r e   i s   n o   I n d e x   t o   A g e n t s   t e x t   t o   i m p o r t .     P l e a s e   t r a n s f e r   t h e m   a n d   i m p o r t   i n t o   t h e   c a t a l o g   m a n u a l l y .  ��#$
�� 
btns# J  &+%% &��& m  &)'' �((  O K��  $ ��)*
�� 
dflt) m  ./���� * ��+��
�� 
disp+ m  25��
�� stic   ��  ��   m  ����  Notify user    �,,  N o t i f y   u s e r� -.- l ==��������  ��  ��  . /0/ O  =V121 O  CU343 I KT����5
�� .pGbRIcRmnull���     ****��  5 ��6��
�� 
bYVl6 m  OP���� ��  4 1  CH��
�� 
cRpB2 m  =@77�                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  0 898 l WW��������  ��  ��  9 :;: Q  W�<=��< l Z�>?@> k  Z�AA BCB r  Z�DED m  Z[��
�� boovfalsE n      FGF 1  {��
�� 
kewnG n  [{HIH 4  t{��J
�� 
cparJ m  wz������I n  [tKLK 4  ot��M
�� 
cfloM m  rs���� L n  [oNON 4  ho��P
�� 
TXTBP m  knQQ �RR  S t a r t B o xO n  [hSTS 4  ch��U
�� 
pageU m  fg���� T 4  [c��V
�� 
docuV o  _b���� 0 docname DocNameC WXW r  ��YZY 4  ����[
�� 
file[ o  ������  0 exhibitorstext ExhibitorsTextZ n      \]\ 9  ����
�� 
insl] n  ��^_^ 4 ����`
�� 
cha ` m  ��������_ n  ��aba 4  ����c
�� 
cfloc m  ������ b n  ��ded 4  ����f
�� 
TXTBf m  ��gg �hh  S t a r t B o xe n  ��iji 4  ����k
�� 
pagek m  ������ j 4  ����l
�� 
docul o  ������ 0 docname DocNameX m��m r  ��non m  ��pp �qq  Y e so o      ���� 0 hasexbindex HasExbIndex��  ? . (Import the Index to Exhibitors text --OK   @ �rr P I m p o r t   t h e   I n d e x   t o   E x h i b i t o r s   t e x t   - - O K= R      ������
�� .ascrerr ****      � ****��  ��  ��  ; sts l ����������  ��  ��  t uvu Q  �wx��w l �yz{y Z �|}����| F  ��~~ = ����� o  ������ 0 needexbindex NeedExbIndex� m  ���� ���  Y e s = ����� o  ������ 0 hasexbindex HasExbIndex� m  ���� ���  N o} r  ���� b  ����� b  ����� b  ����� o  ����
�� 
ret � o  ����
�� 
ret � m  ���� ��� Z T h i s   c a t a l o g   m a y   n e e d   a n   I n d e x   t o   E x h i b i t o r s .� o  ����
�� 
ret � n      ��� 8  ��
�� 
insl� n  ���� 4 ���
�� 
cha � m  	
������� n  ���� 4  ���
�� 
cpar� m  ���� � n  ���� 4  ����
�� 
cflo� m  � ���� � n  ����� 4  �����
�� 
TXTB� m  ���� ���  S t a r t B o x� n  ����� 4  �����
�� 
page� m  ������ � 4  �����
�� 
docu� o  ������ 0 docname DocName��  ��  z \ VNotify user if catalog needs Index to Exhibitors but was not transferred from IBM --OK   { ��� � N o t i f y   u s e r   i f   c a t a l o g   n e e d s   I n d e x   t o   E x h i b i t o r s   b u t   w a s   n o t   t r a n s f e r r e d   f r o m   I B M   - - O Kx R      ������
�� .ascrerr ****      � ****��  ��  ��  v ��� l ��������  ��  ��  � ��� l ������  � 6 0Force QXP to draw all the pages in document --OK   � ��� ` F o r c e   Q X P   t o   d r a w   a l l   t h e   p a g e s   i n   d o c u m e n t   - - O K� ��� I @�����
�� .miscmvisnull���    obj � n  <��� 4 7<���
�� 
cha � m  :;������� n  7��� 4  27���
�� 
cflo� m  56���� � n  2��� 4  +2���
�� 
TXTB� m  .1�� ���  S t a r t B o x� n  +��� 4  &+���
�� 
page� m  )*���� � 4  &���
�� 
docu� o  "%���� 0 docname DocName��  � ��� I AR�����
�� .miscmvisnull���    obj � n  AN��� 4  IN���
�� 
page� m  LM���� � 4  AI���
�� 
docu� o  EH���� 0 docname DocName��  � ���� l SS����~��  �  �~  ��  	� m  	�	��}�}*0	� ��� l VV�|�{�z�|  �{  �z  � ��� O  Vy��� k  \x�� ��� r  \e��� m  \_�� ��� > S a v i n g   t h e   Q u a r k X P r e s s   d o c u m e n t� 1  _d�y
�y 
hEaR� ��x� O  fx��� I nw�w�v�
�w .pGbRIcRmnull���     ****�v  � �u��t
�u 
bYVl� m  rs�s�s �t  � 1  fk�r
�r 
cRpB�x  � m  VY���                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��  � ��� l zz�q�p�o�q  �p  �o  � ��� t  z���� k  ~��� ��� l ~~�n���n  � T NSave the Catalog in the CAT folder of the show code folder on local hard drive   � ��� � S a v e   t h e   C a t a l o g   i n   t h e   C A T   f o l d e r   o f   t h e   s h o w   c o d e   f o l d e r   o n   l o c a l   h a r d   d r i v e� ��� r  ~���� l ~���m�l� c  ~���� b  ~���� b  ~���� o  ~�k�k 0 showcode ShowCode� o  ��j�j 0 
shownumber 
ShowNumber� m  ���� ���    C A T . q x p� m  ���i
�i 
ctxt�m  �l  � o      �h�h 0 
newdocname 
NewDocName� ��� I ���g��
�g .coresavenull���    obj � 4  ���f�
�f 
docu� o  ���e�e 0 docname DocName� �d��
�d 
kfil� l ����c�b� c  ����� l ����a�`� b  ��� � o  ���_�_ 0 catpath CATPath  o  ���^�^ 0 
newdocname 
NewDocName�a  �`  � m  ���]
�] 
ctxt�c  �b  � �\
�\ 
fltp m  ���[
�[ 
docu �Z�Y
�Z 
TPLT m  ���X
�X boovfals�Y  �  l �� I ���W	

�W .coreclosnull���    obj 	 4  ���V
�V 
docu o  ���U�U 0 
newdocname 
NewDocName
 �T�S
�T 
savo m  ���R
�R savono  �S   1 +Quark 9 seems to save as Quark ver 8 files?    � V Q u a r k   9   s e e m s   t o   s a v e   a s   Q u a r k   v e r   8   f i l e s ? �Q I ���P�O
�P .aevtodocnull  �    alis 4  ���N
�N 
file l ���M�L c  �� l ���K�J b  �� o  ���I�I 0 catpath CATPath o  ���H�H 0 
newdocname 
NewDocName�K  �J   m  ���G
�G 
ctxt�M  �L  �O  �Q  � m  z}�F�F�  l ���E�D�C�E  �D  �C    O  �� O  �� k  ��  !  I ���B�A�@
�B .pGbRSpMnnull���     ****�A  �@  ! "�?" I ���>�=�<
�> .aevtquitnull���    obj �=  �<  �?   1  ���;
�; 
cRpB m  ��##�                                                                                      @ alis    h  Macintosh HD               ���H+     0SKProgressBar.app                                               ���Cx�        ����  	                Applications    �!*      �C�&       0  ,Macintosh HD:Applications: SKProgressBar.app  $  S K P r o g r e s s B a r . a p p    M a c i n t o s h   H D  Applications/SKProgressBar.app  / ��   $�:$ l ���9�8�7�9  �8  �7  �:  	 m  ��%%�                                                                                  XPR3  alis    �  Macintosh HD               ���H+   Y�QuarkXPress.app                                                 ��у�S        ����  	                QuarkXPress 10    �!*      уڣ     Y�   0  :Macintosh HD:Applications: QuarkXPress 10: QuarkXPress.app     Q u a r k X P r e s s . a p p    M a c i n t o s h   H D  +Applications/QuarkXPress 10/QuarkXPress.app   / ��  �  �  � &'& l     �6�5�4�6  �5  �4  ' ()( l ��*�3�2* Q  ��+,-+ l ��./0. Z  ��12�1�01 = ��343 o  ���/�/  0 getjudgereport GetJudgeReport4 m  ��55 �66  Y e s2 k   77 898 I  �.:;
�. .rdwropenshor       file: 4   �-<
�- 
file< o  �,�, "0 judgereportpath JudgeReportPath; �+=�*
�+ 
perm= m  �)
�) boovtrue�*  9 >?> l �(@A�(  @ < 6If there are errors, put them in the JUDGE REPORT file   A �BB l I f   t h e r e   a r e   e r r o r s ,   p u t   t h e m   i n   t h e   J U D G E   R E P O R T   f i l e? CDC Z GEF�'�&E > GHG o  �%�% 0 
judgeerror 
JudgeErrorH m  II �JJ  F I C�$KL
�$ .rdwrwritnull���     ****K b  4MNM b  0OPO b  ,QRQ b  (STS b   UVU o  �#�# 0 showcode ShowCodeV o  �"�" 0 
shownumber 
ShowNumberT l  'W�!� W b   'XYX m   #ZZ �[[    J U D G E   E R R O R S :Y o  #&�
� 
ret �!  �   R o  (+�� 0 
judgeerror 
JudgeErrorP o  ,/�
� 
ret N o  03�
� 
ret L �\�
� 
refn\ 4  7?�]
� 
file] o  ;>�� "0 judgereportpath JudgeReportPath�  �'  �&  D ^_^ l HH�`a�  ` @ :Put the list of breeds and judges in the JUDGE REPORT file   a �bb t P u t   t h e   l i s t   o f   b r e e d s   a n d   j u d g e s   i n   t h e   J U D G E   R E P O R T   f i l e_ cdc Z Href��e > HOghg o  HK�� 0 	judgelist 	JudgeListh m  KNii �jj  f I Rn�kl
� .rdwrwritnull���     ****k b  R_mnm b  R[opo b  RWqrq o  RS�� 0 showcode ShowCoder o  SV�� 0 
shownumber 
ShowNumberp l WZs��s m  WZtt �uu     L I S T   O F   J U D G E S :�  �  n o  [^�� 0 	judgelist 	JudgeListl �v�
� 
refnv 4  bj�w
� 
filew o  fi�
�
 "0 judgereportpath JudgeReportPath�  �  �  d x�	x I s�y�
� .rdwrclosnull���     ****y 4  s{�z
� 
filez o  wz�� "0 judgereportpath JudgeReportPath�  �	  �1  �0  / . (Put the judge info where it belongs --OK   0 �{{ P P u t   t h e   j u d g e   i n f o   w h e r e   i t   b e l o n g s   - - O K, R      ���
� .ascrerr ****      � ****�  �  - l ��|}~| k  �� ��� I ����� 
� .rdwrclosnull���     ****� 4  �����
�� 
file� o  ������ "0 judgereportpath JudgeReportPath�   � ���� I �������
�� .sysobeepnull��� ��� long� m  ������ ��  ��  } 4 .If something bad happens, closes the text file   ~ ��� \ I f   s o m e t h i n g   b a d   h a p p e n s ,   c l o s e s   t h e   t e x t   f i l e�3  �2  ) ��� l     ��������  ��  ��  � ��� l �������� O ����� I ��������
�� .aevtquitnull���    obj ��  ��  �  f  ����  ��  � ��� l     ��������  ��  ��  � ��� l ������ I �������
�� .sysobeepnull��� ��� long� m  ������ ��  � ! Let user know it's finished   � ��� 6 L e t   u s e r   k n o w   i t ' s   f i n i s h e d� ���� l     ��������  ��  ��  ��  g  This defines a subroutine   h ��� 2 T h i s   d e f i n e s   a   s u b r o u t i n ed ��� l     ��������  ��  ��  � ��� l     ��������  ��  ��  � ��� i    ��� I     �����
�� .coVScliInull���    obj � o      ���� 0 	theobject 	theObject��  � l   ^���� k    ^�� ��� l     ��������  ��  ��  � ��� O    \��� k   [�� ��� l   ��������  ��  ��  � ��� Z   Y������ =   ��� n    	��� 1    	��
�� 
pnam� o    ���� 0 	theobject 	theObject� m   	 
�� ���  O K� k   �� ��� l   ��������  ��  ��  � ��� l   ������  �  Verify the variables   � ��� ( V e r i f y   t h e   v a r i a b l e s� ��� r    ��� I   �����
�� .SATIUPPE****  @   @ ****� l   ������ c    ��� n    ��� 1    ��
�� 
pcnt� 4    ���
�� 
texF� m    �� ���  S h o w C o d e F i e l d� m    ��
�� 
ctxt��  ��  ��  � o      ���� 0 showcodetext ShowCodeText� ��� l   ��������  ��  ��  � ��� l   ������  � ( "Get the Show Code for single shows   � ��� D G e t   t h e   S h o w   C o d e   f o r   s i n g l e   s h o w s� ��� Z    ������ =   &��� l   $������ I   $�����
�� .corecnte****       ****� n     ��� 2    ��
�� 
cha � o    ���� 0 showcodetext ShowCodeText��  ��  ��  � m   $ %���� � k   ) G�� ��� r   ) :��� I  ) 8�����
�� .SATIUPPE****  @   @ ****� l  ) 4������ n   ) 4��� 7 * 4����
�� 
ctxt� m   . 0���� � m   1 3���� � o   ) *���� 0 showcodetext ShowCodeText��  ��  ��  � o      ���� 0 showcode ShowCode� ��� r   ; A��� n   ; ?��� 4   < ?���
�� 
cha � m   = >���� � o   ; <���� 0 showcodetext ShowCodeText� o      ���� 0 
shownumber 
ShowNumber� ��� r   B E��� m   B C�� ���  S i n g l e� o      ���� 0 cattype CatType� ���� l  F F������  � * $Get the Show Code for combined shows   � ��� H G e t   t h e   S h o w   C o d e   f o r   c o m b i n e d   s h o w s��  � ��� =  J S   l  J Q���� I  J Q����
�� .corecnte****       **** n   J M 2  K M��
�� 
cha  o   J K���� 0 showcodetext ShowCodeText��  ��  ��   m   Q R���� � �� k   V s 	 r   V g

 I  V e����
�� .SATIUPPE****  @   @ **** l  V a���� n   V a 7 W a��
�� 
ctxt m   [ ]����  m   ^ `����  o   V W���� 0 showcodetext ShowCodeText��  ��  ��   o      ���� 0 showcode ShowCode	  r   h m m   h k �   o      ���� 0 
shownumber 
ShowNumber �� r   n s m   n q �  C o m b i n e d o      ���� 0 cattype CatType��  ��  � l  v � k   v �   !"! I  v ���#$
�� .panSdisAnull���    obj # m   v y%% �&& v Y o u   m u s t   e n t e r   a   S h o w   C o d e   a n d   S h o w   N u m b e r   o r   C l u s t e r   C o d e .$ ��'��
�� 
attT'  g   | }��  " ()( l  � ���*+��  *  Reset the field   + �,,  R e s e t   t h e   f i e l d) -��- r   � �./. m   � �00 �11  / n      232 1   � ���
�� 
pcnt3 4   � ���4
�� 
texF4 m   � �55 �66  S h o w C o d e F i e l d��   % Notify user that input is wrong    �77 > N o t i f y   u s e r   t h a t   i n p u t   i s   w r o n g� 898 l  � ���������  ��  ��  9 :;: l  � ���<=��  < : 4Change the results of the Popup Menus into variables   = �>> h C h a n g e   t h e   r e s u l t s   o f   t h e   P o p u p   M e n u s   i n t o   v a r i a b l e s; ?@? r   � �ABA n   � �CDC 1   � ���
�� 
titlD 4   � ���E
�� 
popBE m   � �FF �GG  S h o w T y p e L i s tB o      ���� 0 showtype ShowType@ HIH r   � �JKJ n   � �LML 1   � ���
�� 
titlM 4   � ���N
�� 
popBN m   � �OO �PP  D o c S i z e L i s tK o      ���� 0 docsize DocSizeI QRQ l  � �STUS r   � �VWV n   � �XYX 1   � ���
�� 
titlY 4   � ���Z
�� 
popBZ m   � �[[ �\\  L a y o u t T y p e L i s tW o      ���� 0 
layouttype 
LayoutTypeT  Not implemented yet   U �]] & N o t   i m p l e m e n t e d   y e tR ^_^ l  � ���������  ��  ��  _ `a` l  � ���bc��  b : 4Change the results of the Check Boxes into variables   c �dd h C h a n g e   t h e   r e s u l t s   o f   t h e   C h e c k   B o x e s   i n t o   v a r i a b l e sa efe r   � �ghg m   � �ii �jj  N oh o      ����  0 getjudgereport GetJudgeReportf klk Z  � �mn����m =  � �opo n   � �qrq 1   � ��
� 
pcntr 4   � ��~s
�~ 
butTs m   � �tt �uu , G e t J u d g e R e p o r t C h e c k B o xp m   � ��}
�} boovtruen r   � �vwv m   � �xx �yy  Y e sw o      �|�|  0 getjudgereport GetJudgeReport��  ��  l z{z r   � �|}| m   � �~~ �  N o} o      �{�{ "0 checkringstimes CheckRingsTimes{ ��� Z  ����z�y� =  � ���� n   � ���� 1   � ��x
�x 
pcnt� 4   � ��w�
�w 
butT� m   � ��� ��� . C h e c k R i n g s T i m e s C h e c k B o x� m   � ��v
�v boovtrue� r   ���� m   � ��� ���  Y e s� o      �u�u "0 checkringstimes CheckRingsTimes�z  �y  � ��� r  ��� m  �� ���  N o� o      �t�t $0 deleteringstimes DeleteRingsTimes� ��� Z *���s�r� = ��� n  ��� 1  �q
�q 
pcnt� 4  �p�
�p 
butT� m  �� ��� 0 D e l e t e R i n g s T i m e s C h e c k B o x� m  �o
�o boovtrue� r  &��� m  "�� ���  Y e s� o      �n�n $0 deleteringstimes DeleteRingsTimes�s  �r  � ��� r  +2��� m  +.�� ���  N o� o      �m�m "0 removekwnjudges RemoveKWNJudges� ��� Z 3M���l�k� = 3?��� n  3=��� 1  ;=�j
�j 
pcnt� 4  3;�i�
�i 
butT� m  7:�� ��� . R e m o v e K W N J u d g e s C h e c k B o x� m  =>�h
�h boovtrue� r  BI��� m  BE�� ���  Y e s� o      �g�g "0 removekwnjudges RemoveKWNJudges�l  �k  � ��� r  NU��� m  NQ�� ���  N o� o      �f�f 0 
useheaders 
UseHeaders� ��� Z Vp���e�d� = Vb��� n  V`��� 1  ^`�c
�c 
pcnt� 4  V^�b�
�b 
butT� m  Z]�� ��� $ U s e H e a d e r s C h e c k B o x� m  `a�a
�a boovtrue� r  el��� m  eh�� ���  Y e s� o      �`�` 0 
useheaders 
UseHeaders�e  �d  � ��� r  qx��� m  qt�� ���  N o� o      �_�_ 0 usecurrentdoc UseCurrentDoc� ��� Z y����^�]� = y���� n  y���� 1  ���\
�\ 
pcnt� 4  y��[�
�[ 
butT� m  }��� ��� * U s e C u r r e n t D o c C h e c k B o x� m  ���Z
�Z boovtrue� r  ����� m  ���� ���  Y e s� o      �Y�Y 0 usecurrentdoc UseCurrentDoc�^  �]  � ��� l ���X�W�V�X  �W  �V  � ��� l ���U���U  � : 4Check for Specialties with Check Rings/Times checked   � ��� h C h e c k   f o r   S p e c i a l t i e s   w i t h   C h e c k   R i n g s / T i m e s   c h e c k e d� ��� Z �����T�S� F  ����� = ����� o  ���R�R 0 showtype ShowType� m  ���� ���  S p e c i a l t y� = ����� o  ���Q�Q "0 checkringstimes CheckRingsTimes� m  ���� ���  Y e s� r  ����� m  ���� ���  N o� o      �P�P "0 checkringstimes CheckRingsTimes�T  �S  � ��� l ���O�N�M�O  �N  �M  � ��� l ���L �L    T NNotify user of possible conflict of Use Current Document and automatic headers    � � N o t i f y   u s e r   o f   p o s s i b l e   c o n f l i c t   o f   U s e   C u r r e n t   D o c u m e n t   a n d   a u t o m a t i c   h e a d e r s�  Z ��K�J F  �� l ��	�I�H	 F  ��

 = �� o  ���G�G 0 usecurrentdoc UseCurrentDoc m  �� �  Y e s = �� o  ���F�F 0 
useheaders 
UseHeaders m  �� �  Y e s�I  �H   = �� n  �� 1  ���E
�E 
bhit l ���D�C I ���B
�B .panSdlognull���    obj  m  �� � � H e a d e r s   a r e   n o r m a l l y   s e t   u p   i n   t h e   c u r r e n t   d o c u m e n t .     A r e   y o u   s u r e   y o u   w a n t   t o   c r e a t e   t h e s e   a u t o m a t i c a l l y ? �A
�A 
btns J  ��  !  m  ��"" �##  Y e s! $�@$ m  ��%% �&&  N o�@   �?'(
�? 
dflt' m  ���>�> ( �=)�<
�= 
disp) m  ���;
�; stic   �<  �D  �C   m  ��** �++  N o r  �,-, m  � .. �//  N o- o      �:�: 0 
useheaders 
UseHeaders�K  �J   010 l 		�9�8�7�9  �8  �7  1 232 l 	4564 I 	�67�5
�6 .aevtoappnull  �   � ****7 o  	�4�4 0 
mainscript 
MainScript�5  5 " Do the MainScript subroutine   6 �88 8 D o   t h e   M a i n S c r i p t   s u b r o u t i n e3 9�39 l �2�1�0�2  �1  �0  �3  � :;: = <=< n  >?> 1  �/
�/ 
pnam? o  �.�. 0 	theobject 	theObject= m  @@ �AA * U s e C u r r e n t D o c C h e c k B o x; B�-B k  !UCC DED l !!�,�+�*�,  �+  �*  E FGF Z !SHI�)�(H F  !@JKJ = !-LML n  !+NON 1  )+�'
�' 
pcntO 4  !)�&P
�& 
butTP m  %(QQ �RR * U s e C u r r e n t D o c C h e c k B o xM m  +,�%
�% boovtrueK = 0<STS n  0:UVU 1  8:�$
�$ 
pcntV 4  08�#W
�# 
butTW m  47XX �YY $ U s e H e a d e r s C h e c k B o xT m  :;�"
�" boovtrueI r  COZ[Z m  CD�!
�! boovfals[ n      \]\ 1  LN� 
�  
pcnt] 4  DL�^
� 
butT^ m  HK__ �`` $ U s e H e a d e r s C h e c k B o x�)  �(  G a�a l TT����  �  �  �  �-  ��  � b�b l ZZ����  �  �  �  � n     cdc m    �
� 
cwind o     �� 0 	theobject 	theObject� e�e l ]]����  �  �  �  � &  Do this when a button is clicked   � �ff @ D o   t h i s   w h e n   a   b u t t o n   i s   c l i c k e d� ghg l     ����  �  �  h iji l     ����  �  �  j klk l     �
mn�
  m 4 .Do this when one of the popup menus is changed   n �oo \ D o   t h i s   w h e n   o n e   o f   t h e   p o p u p   m e n u s   i s   c h a n g e dl pqp i    rsr I     �	t�
�	 .coVSactTnull���    obj t o      �� 0 	theobject 	theObject�  s k     �uu vwv l     ����  �  �  w xyx O     �z{z k    �|| }~} l   ����  �  �  ~ � Z    ����� � =   ��� n    	��� 1    	��
�� 
pnam� o    ���� 0 	theobject 	theObject� m   	 
�� ���  S h o w T y p e L i s t� k    T�� ��� l   ��������  ��  ��  � ��� Z    R������ =   ��� n    ��� 1    ��
�� 
titl� n    ��� 1    ��
�� 
cuMI� 4    ���
�� 
popB� m    �� ���  S h o w T y p e L i s t� m    �� ���  A l l - B r e e d� k    5�� ��� r    #��� m    ��
�� boovtrue� n      ��� 1     "��
�� 
pcnt� 4     ���
�� 
butT� m    �� ��� . C h e c k R i n g s T i m e s C h e c k B o x� ��� r   $ ,��� m   $ %��
�� boovfals� n      ��� 1   ) +��
�� 
pcnt� 4   % )���
�� 
butT� m   ' (�� ��� 0 D e l e t e R i n g s T i m e s C h e c k B o x� ���� r   - 5��� m   - .��
�� boovfals� n      ��� 1   2 4��
�� 
pcnt� 4   . 2���
�� 
butT� m   0 1�� ��� . R e m o v e K W N J u d g e s C h e c k B o x��  ��  � l  8 R���� k   8 R�� ��� r   8 @��� m   8 9��
�� boovfals� n      ��� 1   = ?��
�� 
pcnt� 4   9 =���
�� 
butT� m   ; <�� ��� . C h e c k R i n g s T i m e s C h e c k B o x� ��� r   A I��� m   A B��
�� boovtrue� n      ��� 1   F H��
�� 
pcnt� 4   B F���
�� 
butT� m   D E�� ��� 0 D e l e t e R i n g s T i m e s C h e c k B o x� ���� r   J R��� m   J K��
�� boovtrue� n      ��� 1   O Q��
�� 
pcnt� 4   K O���
�� 
butT� m   M N�� ��� . R e m o v e K W N J u d g e s C h e c k B o x��  � # if ShowType is Specialty then   � ��� : i f   S h o w T y p e   i s   S p e c i a l t y   t h e n� ���� l  S S��������  ��  ��  ��  � ��� =  W ^��� n   W Z��� 1   X Z��
�� 
pnam� o   W X���� 0 	theobject 	theObject� m   Z ]�� ���  D o c S i z e L i s t� ���� k   a ��� ��� l  a a��������  ��  ��  � ��� Z   a ������� =  a o��� n   a k��� 1   i k��
�� 
titl� n   a i��� 1   g i��
�� 
cuMI� 4   a g���
�� 
popB� m   c f�� ���  D o c S i z e L i s t� m   k n�� ���  M a g a z i n e� k   r ��� ��� r   r |��� m   r s��
�� boovfals� n      ��� 1   y {��
�� 
pcnt� 4   s y���
�� 
butT� m   u x�� ��� $ U s e H e a d e r s C h e c k B o x� ���� r   } �� � m   } ~��
�� boovtrue  n       1   � ���
�� 
pcnt 4   ~ ���
�� 
butT m   � � � * U s e C u r r e n t D o c C h e c k B o x��  ��  � l  � � k   � �		 

 r   � � m   � ���
�� boovtrue n       1   � ���
�� 
pcnt 4   � ���
�� 
butT m   � � � $ U s e H e a d e r s C h e c k B o x �� r   � � m   � ���
�� boovfals n       1   � ���
�� 
pcnt 4   � ���
�� 
butT m   � � � * U s e C u r r e n t D o c C h e c k B o x��   . (if DocSize is Normal or Large Print then    � P i f   D o c S i z e   i s   N o r m a l   o r   L a r g e   P r i n t   t h e n� �� l  � ���������  ��  ��  ��  ��  �   � �� l  � ���������  ��  ��  ��  { n      m    ��
�� 
cwin o     ���� 0 	theobject 	theObjecty  ��  l  � ���������  ��  ��  ��  q !"! l     ��������  ��  ��  " #$# l     ��������  ��  ��  $ %&% l     ��'(��  '   Quit when window is closed   ( �)) 4 Q u i t   w h e n   w i n d o w   i s   c l o s e d& *+* i    ,-, I     ��.��
�� .appSsQALnull���    obj . o      ���� 0 	theobject 	theObject��  - L     // m     ��
�� boovtrue+ 010 l     ��������  ��  ��  1 232 l     ��������  ��  ��  3 454 l     ��67��  6 Z TThis subroutine replaces ACME replace, which no longer seems to work in Snow Leopard   7 �88 � T h i s   s u b r o u t i n e   r e p l a c e s   A C M E   r e p l a c e ,   w h i c h   n o   l o n g e r   s e e m s   t o   w o r k   i n   S n o w   L e o p a r d5 9:9 i   ;<; I      ��=>�� 0 
switchtext 
switchText= o      ���� 0 t  > ��?@
�� 
from? o      ���� 0 s  @ ��A��
�� 
to  A o      ���� 0 r  ��  < k     1BB CDC r     EFE 1     ��
�� 
txdlF o      ���� 0 d  D GHG r    IJI o    ���� 0 s  J 1    
��
�� 
txdlH KLK r    MNM n   OPO 2   ��
�� 
citmP o    ���� 0 t  N o      ���� 0 t  L QRQ r    STS o    ���� 0 r  T 1    ��
�� 
txdlR UVU O   )WXW r    (YZY b    &[\[  :    \ l   %]����] b    %^_^ J    !`` a��a m    bb �cc  ��  _ 1   ! $��
�� 
rest��  ��  Z o      ���� 0 t  X o    ���� 0 t  V ded r   * /fgf o   * +���� 0 d  g 1   + .��
�� 
txdle h��h o   0 1���� 0 t  ��  : iji l     ��������  ��  ��  j k��k j     "��l�� 60 asdscriptuniqueidentifier ASDScriptUniqueIdentifierl m     !mm �nn . C A T   P a s t e u p . a p p l e s c r i p t��       	��opqrstum��  o ���������������� 0 makeheaders MakeHeaders�� 0 
mainscript 
MainScript
�� .coVScliInull���    obj 
�� .coVSactTnull���    obj 
�� .appSsQALnull���    obj �� 0 
switchtext 
switchText�� 60 asdscriptuniqueidentifier ASDScriptUniqueIdentifierp � X  v� 0 makeheaders MakeHeadersv  wxw �~
�~ .aevtoappnull  �   � ****x �}y�|�{z{�z
�} .aevtoappnull  �   � ****y k    �||  d}} 2�y�y  �|  �{  z �x�w�v�u�t�x 0 groupcounter GroupCounter�w 0 	groupfile 	GroupFile�v 0 	grouptext 	GroupText�u 0 testname TestName�t 0 testdate TestDate{ t�s�r�q�p�o�n�m�l�k�j�i�h�g�f�e ��d ��c�b�a�`�_�^�] ��\ ��[�Z�Y!�X)�W,�V�U2<?ENQ`hk{��������������������"%+58>HKQ[^dnqw������������������T��S!\�R�Q�P�OG�NV�s 0 groupfilelist GroupFileList
�r 
cobj
�q .corecnte****       ****�p 0 catpath CATPath
�o 
ctxt
�n 
file
�m 
perm
�l .rdwropenshor       file
�k .rdwrread****        ****
�j .rdwrclosnull���     ****�i  �h  �g
�f .miscactvnull��� ��� null
�e .aevtquitnull���    obj 
�d 
btns
�c 
dflt
�b 
disp
�a .coVSstoTnull���    obj �` 
�_ .panSdlognull���    obj 
�^ 
cpar
�] 
cha �\��
�[ 
bool�Z �Y��
�X 
from
�W 
to  �V �U 0 
switchtext 
switchText�T 0 shownamelist ShowNameList�S 0 showdatelist ShowDateList
�R 
MDOC�Q 0 docname DocName
�P 
sprd
�O 
TXTB
�N 
cflo�z�Pk��-j kh   .���/%�&E�O*�/�fl O*�/j E�O*�/j 	W HX 
 *�/j 	O�n) *j j UO�a a kva ka *j a  O) *j UoO�a l/a i/�&a  	 �a l/a a /�&a  a & �a l/[�\[Za \Za 2E�Y �a l/[�\[Za \Zi2E�O�a m/[�\[Za \Zi2E�O��-j k�a  �a  a !a "a #a $ %E�Y C�a & �a  a 'a "a (a $ %E�Y #�a ) �a  a *a "a +a $ %E�Y hO�a , �a  a -a "a .a $ %E�Y hO�a / �a  a 0a "a 1a $ %E�Y äa 2 �a  a 3a "a 4a $ %E�Y ��a 5 �a  a 6a "a 7a $ %E�Y ��a 8 �a  a 9a "a :a $ %E�Y c�a ; �a  a <a "a =a $ %E�Y C�a > �a  a ?a "a @a $ %E�Y #�a A �a  a Ba "a Ca $ %E�Y hO�a D �a  a Ea "a Fa $ %E�Yc�a G �a  a Ha "a Ia $ %E�YC�a J �a  a Ka "a La $ %E�Y#�a M �a  a Na "a Oa $ %E�Y�a P �a  a Qa "a Ra $ %E�Y �a S �a  a Ta "a Ua $ %E�Y äa V �a  a Wa "a Xa $ %E�Y ��a Y �a  a Za "a [a $ %E�Y ��a \ �a  a ]a "a ^a $ %E�Y c�a _ �a  a `a "a aa $ %E�Y C�a b �a  a ca "a da $ %E�Y #�a e �a  a fa "a ga $ %E�Y hOPY hO_ h� $�k _ ha i%�%E` hY _ h�%E` hY hO_ j� $�k _ ja k%�%E` jY _ j�%E` jY hOP[OY��Oa l =_ h*a m_ n/a ok/a pa q/a rk/FO_ j*a m_ n/a ok/a pa s/a rk/FUq �Me  ~�M 0 
mainscript 
MainScript~  � �L
�L .aevtoappnull  �   � ****� �K��J�I���H
�K .aevtoappnull  �   � ****� k    ��� l�� ��� ��� (�� ��� ��G�G  �J  �I  � �F�E�D�C�B�A�@�?�>�=�<�;�:�F 0 cattemplate CATTemplate�E 0 catalogtext CatalogText�D 0 paracounter ParaCounter�C 0 	paracount 	ParaCount�B 0 ssname SSName�A 0 ssnameplus1 SSNamePlus1�@ 0 	entrylast 	EntryLast�? 0 ringcounter RingCounter�> 0 
ringssname 
RingSSName�= 0 newbreedtest NewBreedTest�< 0 judgecounter JudgeCounter�; 0 judgessname JudgeSSName�: 0 
newdocname 
NewDocName�9��9�8�7�6�5�4��3��2�1��0�/��������.��-��,��+���*
�)�(#�')�&/�%5�$�#�"B�!� R����������������������#%+R�KMegm���������������(46=@^Ynpwz����
�	��������������� ����BH��d����y���������� !#<>Ddf�����������		(����	4��������	H	S	Y	z������	�����	���	���	���������������������
�������
Q
Y��������
�
�
�
�
�
�
�
���������#��:@M��x����������������&mq�����������#>����H��cn����������������!'Qgp�����������������5����IZ����it����
�9 .miscactvnull��� ��� null
�8 .sysosigtsirr   ��� null
�7 
sisn
�6 .SATIUPPE****  @   @ ****�5 0 currentuser CurrentUser
�4 
alis�3 0 localshowpath LocalShowPath�2  0 servershowpath ServerShowPath�1 0 showcode ShowCode�0 0 catpath CATPath�/ 0 docsize DocSize�. 0 
judgeerror 
JudgeError�- 0 	judgelist 	JudgeList�, 0 
shownumber 
ShowNumber
�+ 
ctxt�* 0 
agentstext 
AgentsText�)  0 exhibitorstext ExhibitorsText�( "0 judgereportpath JudgeReportPath�' 0 needexbindex NeedExbIndex�& 0 hasexbindex HasExbIndex�% 0 shownamelist ShowNameList�$ 0 showdatelist ShowDateList
�# afdrscr�
�" .earsffdralis        afdr�! 0 iconpath iconPath�  0 usecurrentdoc UseCurrentDoc
� 
cfol
� .coredoexbool        obj 
� 
bool�
� .aevtquitnull���    obj 
� 
btns
� 
dflt
� 
disp
� stic    � 
� .sysodlogaskr        TEXT�  
� 
pnam
� 
file� 0 groupfilelist GroupFileList
� 
cobj
� .corecnte****       ****�  0 groupfilecount GroupFileCount� 0 
useheaders 
UseHeaders
� stic   
� 
prdt
� .corecrel****      � null
�
 
insh
�	 .coreclon****      � ****
� .coredeloobj        obj 
� 
pALL
� 
KPRF
� savoyes 
� 
KAUP
� savono  
� 
RFLW
� .aevtodocnull  �    alis
�  .sysodelanull��� ��� nmbr
�� 
docu�� 0 docname DocName
�� 
TXTB
�� 
CUBX
�� 
pcls
�� stic   
�� .aevtoappnull  �   � ****
�� 
cflo
�� 
cha ��  ��  
�� 
savo
�� .coreclosnull���    obj 
�� .miscmvisnull���    obj 
�� 
page��*0
�� 
cpar
�� 
TEXT
�� 
titl
�� 
hEaR
�� 
fOtR
�� aliNriTA
�� 
fTaG
�� 
iMGe
�� 
sHwD
�� 
cRpB
�� 
iDtM
�� .pGbRStMnnull���     ****�� 
�� 
vMaX
�� 
bYVl
�� .pGbRIcRmnull���     ****
�� 
PRSS
�� 
kewn
�� 
ledg
�� 
rtyp
�� .XPRSCOER****���    ****����
�� 
txst
�� 
onst
�� stylbold�� "0 checkringstimes CheckRingsTimes�� 
�� 
ret ������  0 getjudgereport GetJudgeReport
�� 
phsc�� $0 deleteringstimes DeleteRingsTimes�� 	
�� 
ptsz�� "0 removekwnjudges RemoveKWNJudges
�� 
insl
�� 
PAAT
�� 
spaf
�� 
stsh
�� 
qpro
�� 
kfil
�� 
fltp
�� 
TPLT
�� .coresavenull���    obj 
�� .pGbRSpMnnull���     ****
�� 
perm
�� .rdwropenshor       file
�� 
refn
�� .rdwrwritnull���     ****
�� .rdwrclosnull���     ****
�� .sysobeepnull��� ��� long�H��q*j O*j �,j E�O)��/E�O)��/E�O��%�%E�O��  )�a /E�Y )�a   )�a /E�Y �a   )�a /E�Y hOa E` Oa E` O�a %�%_ %a %a &E�O�a %�%_ %a %a &E` O�a  %�%_ %a !%a &E` "O��%_ %a #%a &E` $Oa %E` &Oa 'E` (Oa )E` *Oa +E` ,Oa -j .a &a /%E` 0O_ 1a 2 �*a 3�/a 3�/j 4	 *a 3�/a 3�/j 4a 5& Ea 6n) *j j 7UOa 8�%a 9%a :a ;kva <ka =a >a ? @O) *j 7UoY hO*a 3�/a 3�/j 4 Ea 6n) *j j 7UOa A�%a B%a :a Ckva <ka =a >a ? @O) *j 7UoY hO*a 3�/a 3�/j 4 Ea 6n) *j j 7UOa D�%a E%a :a Fkva <ka =a >a ? @O) *j 7UoY hO*a 3�/a 3�/a 3,a G[a H,\Za I>1j 4 Ia 6n) *j j 7UOa J�%_ %a K%a :a Lkva <ka =a >a ? @O) *j 7UoY hO*a 3�/a 3�/a 3a M/a Na O�%_ %a P%/j 4 :a 6na Q�%_ %a R%a :a Skva <ka =a >a ? @O) *j 7UoY hO*a 3�/a 3�/a 3a T/a Na U�%_ %a V%/j 4 Ia 6n) *j j 7UOa W�%_ %a X%a :a Ykva <ka =a >a ? @O) *j 7UoY hO*a 3��%a Z%a &/a N-a H,a G[a H,\Za [>1E` \O_ \a ]-j ^E` _O_ `a a 	 _ _j a 5& 6a 6na b�%a c%a :a da elva <ka =a fa ? @Oa gE` `oY hO_ `a h 	 _ _j a 5& .a 6na i�%a j%a :a ka llva <ka =a fa ? @oY hO*a 3�/a 3�/a 3a m/a N�_ %a n%/j 4 2a 6na o�%_ %a p%a :a qa rlva <ka =a fa ? @oY hOa 6n�a 3,a sa H�ll tO*a 3�/a 3�/a 3a u/a v*a 3�/a 3�/l wO*a 3�/a 3�/a 3a x/a v*a 3�/a 3�/l wO*a 3�/a 3�/a 3a y/a N-j zO*a 3�/a 3�/a 3a {/a N-j zOa Ha |�%a }%l*a 3�/a 3�/a 3a ~/a ,FoOa � 0��&a �a �a �a �a �fa ? �Olj �O*a �k/a H,E` �UOPY�a �*j O*a �k/j 4 ?a 6n) *j j 7UOa �a :a �kva <ka =a >a ? @O) *j 7UoY hO*a �_ �/a �a �/j 4	 *a �,a �,a �a 5& ?a 6n) *j j 7UOa �a :a �kva <ka =a >a ? @O) *j 7UoY N*a �_ �/a �a �/j 4 6a 6na �a :a �a �lva <la =a �a ? @oOa �*a �,a H,FY hOPUO*a 3�/a 3�/j 4 l�E�O��%a �%E�O*a 3�/a 3�/j 4 Ea 6n) *j j 7UOa ��%a �%a :a �kva <ka =a >a ? @O) *j 7UoY hOPY hO*a 3�a &/a Na ��%_ %a �%/j 4 Ia 6n) *j j 7UOa ��%_ %a �%a :a �kva <ka =a >a ? @O) *j 7UoY hO*a 3�a &/a Na ��%_ %a �%/j 4 Ia 6n) *j j 7UOa ��%_ %a �%a :a �kva <ka =a >a ? @O) *j 7UoY hO*a 3�a &/a N-a H,a G[a H,\Za �>1E` \O_ \a ]-j ^E` _O_ _j  6a 6na ��%a �%a :a �a �lva <ka =a fa ? @oOa �E` `Y hOPOPUOa 6n_ `a �  b   j �Y hoOa �
[*j Oa 6n S_ 1a � 
 $*a �_ �/a �a �/a �k/a �-j ^j a 5&  *a N�/*a �_ �/a �a �/a �k/FY hW aX � �a 6n*a �_ �/a �a �l �Oa � *j 7UO) *j j 7UOa �a :a �kva <ka =a >a ? @O) *j 7UooOa 6n*a �_ �/a �a �/a �k/a �i/j �O*a �_ �/a �k/j �oOa �n*a �_ �/a �k/�kE�O*a �a �/a �k/a �-j ^a �&E�Oa � d*j Oa �*a �,FOa �*a �,FOa �*a �,FOa �*a �,FO_ 0*a �,FOe*a �,FO*a �, f*a �,FO*j �O�a �*a �,FUUOhZa � $�a �%a &*a �,FO*a �, *a �kl �UUO*a �a �/a �k/Ģ*a �-j ^  Y hO (*a ��/a �,a H,E�O*a ��k/a �,a H,E�W X � �hO 5�a � 	 *a ��/a �k/a � a 5& e*a ��k/a �,FY hW X � �hO F*a ��/a �,e 	 !*a ��k/a �,Ea �a �l �a � a 5& f*a ��/a �,FY hW X � �hO )�a � 	 �a � a 5& f*a ��/a �,FY hW X � �hO )�a � 	 �a � a 5& e*a ��/a �,FY hW X � �hO �a �  f*a ��k/a �,FY hW X � �hO )�a � 	 	�� a 5& a �*a ��/a �,FY hW X � �hO >�a �	 %*a ��/a �a �/a �,Ea �,a ]k/a � a 5& a �E` &Y hW X � �hO �_ �a �  ��a �  ��a � � �ka �kh *a ���/a �,a H,E�O�a � 	 *a ���/a �a 5&	 *a ���/a �a 5&
 �a � a 5& @_ _ �%*a ��/[a �\[Zk\Za �2a &a �%_ �%*a ���/%_ �%%E` OY h[OY�lY hY hY hW X � �hO hW X � �hO
_ �a �  ��a � 
 A�a � 	 *a ��/a �a 5&	 *a ��/a �a 5&	 *a ��/a �a 5&a 5& �kE�O �ka �kh 
*a ���/a �,a H,E�O�a �  b�k  -_ _ �%_ �%*a ��/[a �\[Zk\Za �2a &%E` Y hO_ _ �%*a ���/[a �\[Zk\Za �2a &%E` OjE�Y �a �	 �a �a 5& Y h[OY�fY hY hW X � �hOPUO�kE�O�kE�OP[OY��O*a �a �/a �k/�a � a *a �,FO*a �, *a �kl �UUO +a*a �-a G[[a �,\Za8\[\Za@A1a,FW X � �hOa � *a �, *a �kl �UUO +_a  *a �-a G[a �,\Za81j zY hW X � �hOa � *a �, *a �kl �UUO 1*a �-a G[a �,\Za81 *a -a G[\Za	81j zUW X � �hOa � *a �, *a �kl �UUO -�a
  !a*a �-a,a G[a �,\Za81FY hW X � �hOa � *a �, *a �kl �UUO -_a  f*a �-a G[a �,\Za81a �,FY hW X � �hOa � *a �, *a �kl �UUO <_ �a 	 _ aa 5&  _ �_ �%_ %*a �l/a �i/a3FY hW X � �hOPUOPUOa � *a �, *a �kl �UUO 4_a  &aaall*a �_ �/aa/a,FY hW X � �hOa � *a �, *a �kl �UUO Wf*a �_ �/a �k/a �a/a �k/a �a �/a �,FO*a N_ /*a �_ �/a �k/a �a/a �k/a �i/a4FW -X � �a 6n*j Oaa :akva <ka =a �a ? @oOa � *a �, *a �kl �UUO _f*a �_ �/a �k/a �a/a �k/a �a �/a �,FO*a N_ "/*a �_ �/a �k/a �a /a �k/a �i/a4FOa!E` (W X � �hO X_ &a" 	 _ (a# a 5& <_ �_ �%a$%_ �%*a �_ �/a �k/a �a%/a �k/a �l/a �i/a3FY hW X � �hO*a �_ �/a �k/a �a&/a �k/a �i/j �O*a �_ �/a �k/j �OPoOa � a'*a �,FO*a �, *a �kl �UUOa 6n�_ %a(%a &E�O*a �_ �/a)ͬ%a &a*a �a+fa ?,O*a ��/a �a �l �O*a Nͬ%a &/j �oOa � *a �, *j-O*j 7UUOPUO �_ �a.  �*a N_ $/a/el0O_ a1 -�_ %a2_ �%%_ %_ �%_ �%a3*a N_ $/l4Y hO_ a5 !�_ %a6%_ %a3*a N_ $/l4Y hO*a N_ $/j7Y hW X � �*a N_ $/j7Omj8O) *j 7UOlj8r �����������
�� .coVScliInull���    obj �� 0 	theobject 	theObject��  � ������ 0 	theobject 	theObject�� 0 showcodetext ShowCodeText� O�����������������������������%����05��F����O��[��i����tx~�������������������������������"%������������*.��@QX_
�� 
cwin
�� 
pnam
�� 
texF
�� 
pcnt
�� 
ctxt
�� .SATIUPPE****  @   @ ****
�� 
cha 
�� .corecnte****       ****�� �� �� 0 showcode ShowCode�� 0 
shownumber 
ShowNumber�� 0 cattype CatType
�� 
attT
�� .panSdisAnull���    obj 
�� 
popB
�� 
titl�� 0 showtype ShowType�� 0 docsize DocSize�� 0 
layouttype 
LayoutType��  0 getjudgereport GetJudgeReport
�� 
butT�� "0 checkringstimes CheckRingsTimes�� $0 deleteringstimes DeleteRingsTimes�� "0 removekwnjudges RemoveKWNJudges�� 0 
useheaders 
UseHeaders�� 0 usecurrentdoc UseCurrentDoc
�� 
bool
�� 
btns
�� 
dflt
�� 
disp
�� stic   �� 
�� .panSdlognull���    obj 
�� 
bhit
�� .aevtoappnull  �   � ****��_��,W��,� *��/�,�&j E�O��-j 	�  #�[�\[Zk\Z�2j E�O���/E�O�E�OPY F��-j 	�  "�[�\[Zk\Z�2j E�Oa E�Oa E�Y a a *l Oa *�a /�,FO*a a /a ,E` O*a a /a ,E` O*a a /a ,E` Oa E`  O*a !a "/�,e  a #E`  Y hOa $E` %O*a !a &/�,e  a 'E` %Y hOa (E` )O*a !a */�,e  a +E` )Y hOa ,E` -O*a !a ./�,e  a /E` -Y hOa 0E` 1O*a !a 2/�,e  a 3E` 1Y hOa 4E` 5O*a !a 6/�,e  a 7E` 5Y hO_ a 8 	 _ %a 9 a :& a ;E` %Y hO_ 5a < 	 _ 1a = a :&	 ,a >a ?a @a Alva Bla Ca Da E Fa G,a H a :& a IE` 1Y hOb  j JOPY D��,a K  9*a !a L/�,e 	 *a !a M/�,e a :& f*a !a N/�,FY hOPY hOPUOPs ��s�������
�� .coVSactTnull���    obj �� 0 	theobject 	theObject��  � �� 0 	theobject 	theObject� ��������������������
� 
cwin
� 
pnam
� 
popB
� 
cuMI
� 
titl
� 
butT
� 
pcnt� ���, ���,�  K*��/�,�,�  e*��/�,FOf*��/�,FOf*��/�,FY f*��/�,FOe*��/�,FOe*��/�,FOPY P��,a   E*�a /�,�,a   f*�a /�,FOe*�a /�,FY e*�a /�,FOf*�a /�,FOPY hOPUOPt �-�����
� .appSsQALnull���    obj � 0 	theobject 	theObject�  � �� 0 	theobject 	theObject�  � eu �<�����~� 0 
switchtext 
switchText� 0 t  � �}�|�
�} 
from�| 0 s  � �{�z�y
�{ 
to  �z 0 r  �y  � �x�w�v�u�x 0 t  �w 0 s  �v 0 r  �u 0 d  � �t�sb�r
�t 
txdl
�s 
citm
�r 
rest�~ 2*�,E�O�*�,FO��-E�O�*�,FO� *5�kv*�,%%E�UO�*�,FO�ascr  ��ޭ