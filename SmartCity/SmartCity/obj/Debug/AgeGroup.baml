   M S B A M L   `   `   `  ����D  @SmartCity, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null%clr-namespace:SmartCity	SmartCity  5   	       SmartCity.AgeGroup   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   )localclr-namespace:SmartCity     5   	     � Title$  AgeGroup��5   	   $��309.308��6   $��484.84��6+    � 	Resources 5	         MyButtonStyle �� 
TargetType �� Property �� Value �� 
TargetType �� Padding �� CornerRadius �� Triggers	 P� Property
 P� Value �� 
TargetName��%  &	        �� 5
   
   " ��6&   .�5      ��  �@�OverridesDefaultStyle . 66   �� 5       � ��$ 5q�6'   �� 5       � �� 5      �� 5      " ��6&   .R�5      �� $��border��6!   $��0q�5      $	 4,2q�5      
�������$ 3��5      #��z��5      ._�5      �� $��Center=�6/   $��Center=�6L   5       5      P� 5      	 �@J�IsMouseOver
 . . �5   "   �� $ border��6)    � ��
 �   �6T   5      5      5      5       5!      .��5"      � ��5#   
   �� 5$       �� EndPoint$ 0.5,1&�6"    �� 
StartPoint$ 0.5,0&�63   .��5%      �  � Color$ Black��6    � Offset$ 0Q�6-   � 5&      $ 	#FFA5DCEC��6   $ 0.032Q�61   5'      .+�5)   
   �� -   5         ��Name$ label��5)      $��I need:��6   $
��Left=�61   $��	30,30,0,0q�6L   $	��Top=�6_   $��35��6w   $��74��6�   $��16(�6�   �� 5*   
   -   5         ��Name$ checkBox��5*      $��A doctor��6%   $
��Left=�68   $��
109,40,0,0q�6S   $	��Top=�6g   6   �� 5+   
   -   5        $ 	checkBox2��5+      $��Police��6&   $
��Left=�67   $��
109,66,0,0q�6R   $	��Top=�6f   6~   �� 5,   
   -   5        $ 	checkBox3��5,      $��Fire Department��6&   $
��Left=�6@   $��
109,92,0,0q�6[   $	��Top=�6o   6�   �� 5-   
   -   5        $ 	checkBox4��5-      $��Supermarket services��6&   $
��Left=�6E   $��109,118,0,0q�6`   $	��Top=�6u   6�   �� 5.   
   -   5        $ 	checkBox5��5.      $2��,Other (please mention below other services):��6&   $
��Left=�6]   $��109,144,0,0q�6x   $	��Top=�6�   6�   �� 5/   
   -   5         ��Name$ textBox��5/      $
��Left=�6#   $��64��6>   $��
25,170,0,0q�6J    �� TextWrapping$
 Wrap=�6^   $	��Top=�6r   $	��434��6�   {�.  6�   �� 50   
   -   5         ��Name$ button��50      $��Submit��6!    � ToolTip$- 'Send your request to the Administration��62   $
��Left=�6d   $��358,239,0,0q�6   $	��Top=�6�   $��75��6�   $��29��6�   $��14(�6�   ���	#FFDCE3E86�   �� 51   
   -	   5        $ button1��51      $�� ��6"   $
��Left=�6-   $��
427,10,0,0q�6H   $	��Top=�6\   $��40��6t   $��33��6    � Cursor$
 Hand��6�   $� �Click the checkboxes regarding your requests and fill the box to send additional ones, if necessary. Click Submit to send your requests to the Municipality Administration.��6�   $��0q�6O  ��52      �� 53       �� ImageSource$ img/help.png��6   55      �� 56   
   -
   5        $ 	checkBox1��56      $��I am OK!!!:)��6&   $
��Left=�6=   $��
312,92,0,0q�6X   $	��Top=�6l   6�   �� 57   
   -   5        $ label1��57      $%��(mainly if asked by the system)��6    $
��Left=�6J   $��324,107,0,0q�6e   $	��Top=�6z   $��26��6�   $��8(�6�   �� 58   
   -   5        $
 back��58      $�� ��6   #��[  6*   $ Go Back��6Q   $
��Left=�6c   $��
345,10,0,0q�6~   $	��Top=�6�   $��37��6�   $��43��6�   ��59      �� 5:      $ img/back.png��6   5<      5=      5>      