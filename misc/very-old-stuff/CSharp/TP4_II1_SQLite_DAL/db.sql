SQLite format 3   @                                                                            �    ������                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
      	         b �b                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      M %)iM a c h i n J a c q u e s M a c h i n @ s u p e r h o t m a i l . c o m M %uD u T r u c J e a n J e a n . D u t r u c @ f r e e a s a b i r d . f r    � �                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  "IA d m i n i s t r a t e u r s     ��R                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        7�` MS a l l e   P r o j e t s   2 A @3333333@7������3�^ ES a l l e   I n f o   2 2 2 @2333333@6�     3� ES a l l e   I n f o   1 3 4 @3333333@7������?� ]S a l l e   I n f o   I n d u s   1 3 3 @2333333@6�        � �c                                                                                                                                                                                                                                                                                                                                                                                                                                                                  �!II�t a b l e A d m i n i s t r a t e u r s A d m i n i s t r a t e u r s C R E A T E   T A B L E   A d m i n i s t r a t e u r s   ( 
         I d A d m   I N T E G E R   P R I M A R Y   K E Y   A U T O I N C R E M E N T   N O T   N U L L , 
         N o m A d m   T E X T   N O T   N U L L , 
         P r e n o m   T E X T   N O T   N U L L , 
         E m a i l   T E X T   N O T   N U L L 
 ) �!II�%t a b l e s q l i t e _ s e q u e n c e s q l i t e _ s e q u e n c e C R E A T E   T A B L E   s q l i t e _ s e q u e n c e ( n a m e , s e q )    L Lc                                                                                                                                                                                                                                                                                                                                �!%%�at a b l e S a l l e s S a l l e s C R E A T E   T A B L E   S a l l e s   ( 
         I d S a l l e   I N T E G E R   P R I M A R Y   K E Y   N O T   N U L L , 
         N o m S a l l e   T E X T   N O T   N U L L , 
         T e m p M i n   R E A L   N O T   N U L L , 
         T e m p M a x   R E A L   N O T   N U L L , 
         S u p e r v i s e u r   I N T E G E R   N O T   N U L L , 
         F O R E I G N   K E Y   ( S u p e r v i s e u r )   R E F E R E N C E S   A d m i n i s t r a t e u r s ( I d A d m ) 
 ) �!A%�Qi n d e x I d x _ F k _ S a l l e s S a l l e s C R E A T E   I N D E X   I d x _ F k _ S a l l e s   O N   S a l l e s ( S u p e r v i s e u r ) 
   � ����                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     � � � �   
 ���B �G
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  9��O %Y �c o u c o u 2 0 1 2 - 0 4 - 0 6   1 8 : 3 6 : 3 4 9�K %Y �c o u c o u 2 0 1 2 - 0 4 - 0 6   0 1 : 0 4 : 4 3 9�S %Y �c o u c o u 2 0 1 2 - 0 4 - 0 6   0 0 : 5 9 : 2 1 ?  1Y �E m u l a t e u r 2 0 1 2 - 0 3 - 3 0   1 4 : 4 5 : 0 3 ?�I 1Y �P a i l l a s s e 2 0 1 0 - 0 3 - 1 9   1 1 : 2 2 : 5 3 ?�H 1Y �P a i l l a s s e 2 0 1 0 - 0 3 - 1 9   1 1 : 2 2 : 5 3 ;� )Y �P l a f o n d 2 0 1 0 - 0 3 - 1 9   1 1 : 2 2 : 5 3 ;� )Y �P l a f o n d 2 0 1 0 - 0 3 - 1 9   1 1 : 2 2 : 5 3    r rG                                                                                                                                                                                                                                                                                                                                                                      �R!99�5t a b l e E q u i p e m e n t s E q u i p e m e n t s C R E A T E   T A B L E   E q u i p e m e n t s   ( 
         R a b b i t N u m   I N T E G E R   P R I M A R Y   K E Y   N O T   N U L L , 
         S a l l e   I N T E G E R   N O T   N U L L , 
         P o s i t i o n   T E X T , 
         D a t e M i s e E n S e r v i c e   D A T E T I M E , 
         F O R E I G N   K E Y   ( S a l l e )   R E F E R E N C E S   S a l l e s ( I d S a l l e ) 
 ) �6!U9�ai n d e x I d x _ F k _ E q u i p e m e n t s E q u i p e m e n t s 
C R E A T E   I N D E X   I d x _ F k _ E q u i p e m e n t s   O N   E q u i p e m e n t s ( S a l l e ) 
   � ��������                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         ��� �/� �� �  � � � � � � � �   �    �)���N��w= � � f ,8%Y �2 3 , 5 7 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 4 6!Y �2 5 , 5 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 4 -Y ��2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 4 8%Y �2 8 , 3 1 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 2 4Y �2 9 , 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 2 8%Y �2 3 , 5 7 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 2 6!Y �2 5 , 5 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 2 -Y ��2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 2 8
%Y �2 8 , 3 1 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 0 4	Y �2 9 , 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 0 8%Y �2 3 , 5 7 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 0 6!Y �2 5 , 5 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 0 -Y ��2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 0 8%Y �2 8 , 3 1 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 3 8 4Y �2 9 , 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 3 7 8%Y �2 3 , 5 7 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 3 7 6!Y �2 5 , 5 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 3 7 -Y ��2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 :      � �i                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            �~!))�-t a b l e M e s u r e s M e s u r e s C R E A T E   T A B L E   M e s u r e s   ( 
         I d E q   I N T E G E R   N O T   N U L L , 
         M e s u r e   R E A L   N O T   N U L L , 
         D a t e M e s u r e   D A T E T I M E   N O T   N U L L , 
         F O R E I G N   K E Y   ( I d E q )   R E F E R E N C E S   E q u i p e m e n t s ( R a b b i t N u m ) 
 ) �!E)�=i n d e x I d x _ F k _ M e s u r e s M e s u r e s C R E A T E   I N D E X   I d x _ F k _ M e s u r e s   O N   M e s u r e s ( I d E q ) 
   4 ����rP����kI����dB���];���xV4                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 � � � �  � � � �  � � � �  � � � �  �
 �	 � �  � � � �     $  $                        �j	)9)�mt r i g g e r f k i _ M e s u r e s M e s u r e s  C R E A T E   T R I G G E R   f k i _ M e s u r e s 
 B E F O R E   I N S E R T   O N   M e s u r e s 
 F O R   E A C H   R O W   B E G I N 
             S E L E C T   R A I S E ( R O L L B A C K ,   ' v i o l a t i o n   c l e f   e t r a n g e r e ' ) 
             W H E R E     ( S E L E C T   R a b b i t N u m   F R O M   E q u i p e m e n t s   W H E R E   R a b b i t N u m   =   N E W . I d E q )   I S   N U L L ; 
 E N D �l
)9)�qt r i g g e r f k u _ M e s u r e s M e s u r e s  C R E A T E   T R I G G E R   f k u _ M e s u r e s 
 B E F O R E   U P D A T E   O N   M e s u r e s 
 F O R   E A C H   R O W   B E G I N 
             S E L E C T   R A I S E ( R O L L B A C K ,   ' v i o l a t i o n   c l e f   e t r a n g e r e ' ) 
             W H E R E     ( S E L E C T   R a b b i t N u m   F R O M   E q u i p e m e n t s   W H E R E   R a b b i t N u m   =   N E W . I d E q   )   I S   N U L L ; 
 E N D    � �� 7 3                                      �R==�1v i e w O P S a l l e E q u i p O P S a l l e E q u i p  C R E A T E   V I E W   O P S a l l e E q u i p   A S   S E L E C T   *   F R O M   a d m i n i s t r a t e u r s ,   ( S E L E C T   *   F R O M   e q u i p e m e n t s , s a l l e s   W H E R E   S a l l e = I d S a l l e )   W H E R E   S u p e r v i s e u r = I d A d m �b)I9�=t r i g g e r f k d _ E q u i p e m e n t s E q u i p e m e n t s  C R E A T E   T R I G G E R   f k d _ E q u i p e m e n t s 
 B E F O R E   D E L E T E   O N   E q u i p e m e n t s 
     F O R   E A C H   R O W   B E G I N 
             D E L E T E   F R O M   M e s u r e s   W H E R E   I d E q   =   O L D . R a b b i t N u m ; 
     E N D �YY�mv i e w E q u i p S a l l e O p e r a t e u r E q u i p S a l l e O p e r a t e u r  C R E A T E   V I E W   E q u i p S a l l e O p e r a t e u r   A S   S E L E C T   *   F R O M   E q u i p e m e n t s ,   S a l l e s   W H E R E   S a l l e = I d S a l l e    n ��a)��P��n1 � � � Q                                       6!Y �2 3 , 1 8 2 0 1 2 - 0 3 - 3 0   1 3 : 5 3 : 3 6 6!Y �2 3 , 1 8 2 0 1 2 - 0 3 - 3 0   1 3 : 5 3 : 3 4 6!Y �2 3 , 1 8 2 0 1 2 - 0 3 - 3 0   1 3 : 5 3 : 3 2 6!Y �2 3 , 1 8 2 0 1 2 - 0 3 - 3 0   1 3 : 5 3 : 3 1 6!Y �2 3 , 1 8 2 0 1 2 - 0 3 - 3 0   1 3 : 5 3 : 3 0 6!8%Y �2 8 , 3 1 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 9 4Y �2 9 , 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 9 8%Y �2 3 , 5 7 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 9 6!Y �2 5 , 5 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 9 -Y ��2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 9 8%Y �2 8 , 3 1 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 7 4Y �2 9 , 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 7 8%Y �2 3 , 5 7 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 7 6!Y �2 5 , 5 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 7 -Y ��2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 7 8%Y �2 8 , 3 1 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 4 4Y �2 9 , 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 4     , ��_)���N��w= � � f ,8%Y �2 3 , 5 7 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 4 6!Y �2 5 , 5 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 4 -Y ��2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 4 8%Y �2 8 , 3 1 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 2 4Y �2 9 , 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 2 8%Y �2 3 , 5 7 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 2 6!Y �2 5 , 5 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 2 -Y ��2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 2 8
%Y �2 8 , 3 1 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 0 4	Y �2 9 , 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 0 8%Y �2 3 , 5 7 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 0 6!Y �2 5 , 5 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 0 -Y ��2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 4 0 8%Y �2 8 , 3 1 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 3 8 4Y �2 9 , 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 3 7 8%Y �2 3 , 5 7 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 3 7 6!Y �2 5 , 5 5 2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 3 7 -Y ��2 0 1 2 - 0 3 - 3 0   1 5 : 2 0 : 3 7    P ��P                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  0%AS a l l e s I d x _ F k _ S a l l e s 4   2 D9UE q u i p e m e n t s I d x _ F k _ E q u i p e m e n t s 5   3 6)EM e s u r e s I d x _ F k _ M e s u r e s 3 0   6     m                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            �R==�1v i e w O P S a l l e E q u i p O P S a l l e E q u i p  C R E A T E   V I E W   O P S a l l e E q u i p   A S   S E L E C T   *   F R O M   a d m i n i s t r a t e u r s ,   ( S E L E C T   *   F R O M   e q u i p e m e n t s , s a l l e s   W H E R E   S a l l e = I d S a l l e )   W H E R E   S u p e r v i s e u r = I d A d m �!==�)t a b l e s q l i t e _ s t a t 1 s q l i t e _ s t a t 1 C R E A T E   T A B L E   s q l i t e _ s t a t 1 ( t b l , i d x , s t a t ) 