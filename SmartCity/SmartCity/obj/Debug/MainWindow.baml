   M S B A M L   `   `   `  ����D  @SmartCity, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null%clr-namespace:SmartCity	SmartCity  5   	       SmartCity.MainWindow   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   )localclr-namespace:SmartCity     5   	     � WindowStartupLocation$  CenterScreen=�5   	    � Title$ 
MainWindow��5	   	   $	��350��6   $	��525��6)    � 
ResizeMode$ NoResize=�65   $��Center=�6K    � 	Resources 5
         MyButtonStyle �� 
TargetType �� Property �� Value �� 
TargetType �� Padding	 �� CornerRadius
 �� Triggers P� Property P� Value �� 
TargetName��%  &	        �� 5   
   " ��6&   .�5      ��  �@�OverridesDefaultStyle . 66   �� 5       � ��$ 5q�6'   �� 5       � �� 5      �� 5      " ��6&   .R�5      �� $��border��6!   $��0q�5      $	 4,2q�5      
�������$	 3��5      #��z��5      ._�5      �� $��Center=�6/   $��Center=�6L   5      
 5      P� 5       �@J�IsMouseOver . . �5   "   �� $ border��6)    � ��
 �   �6T   5      5      5       5!      5"      .��5#      � $��0,0,-156,-58q�6   ��5$   
   �� 5%       �� ImageSource$ img/logo.jpg��6    � ColumnDefinitions 5'   
   �� 5(      $	��80* �6   �� 5)      $	��93* �6   .+�5+   
   �� -   5         ��Name$ signin��5+      $��Sign In��6!   $
��Left=�63   $��296,264,0,0q�6N   $	��Top=�6c   $��84��6{    � ToolTip$ Enter the app��6�   $��35��6�   $��2��6�   �� 5,   
   -   5        $
 exit��5,      $
��Exit��6   $
��Left=�6.   $��124,264,0,0q�6I   $	��Top=�6^   $��84��6v   $��35��6�   $ Exit the app��6�   $��1��6�    J� RenderTransformOrigin$ 0.376,-0.543&�6�   �� 5-   
   -   5         ��Name$
 user��5-      $
��Left=�6    $��23��6;   $��
37,117,0,0q�6G    �� TextWrapping$
 Wrap=�6[   $	��Top=�6o   $	��120��6�   $��1��6�   G� 5.   
   -   5         G�Name$
 pass��5.       � Cursor$ IBeam��6$   $
��Left=�63   &   System.Windows.Media.TextOptions   TextHintingMode$ Fixed=�6N   $��
37,178,0,0q�6r   $	��Top=�6�   $	��120��6�    G� Password$ Password��6�    G� PasswordChar$ *��6�   $��1��6�   �� 5/   
   -   5        $ button��5/      $�� ��6!   $
 Hand��6,   $` ZPlease write your username and your password and you will enter to the corresponding menu.��6:   $
��Left=�6�   $��
310,10,0,0q�6�   $	��Top=�6�   $��43��6�   $��35��6�   $��0q�6�   #��[  6  $��1��6M  ��50      �� 51      $ img/help.png��6   53      �� 54   
   -   5         ��Name$ label��54      $��	Username:��6   $
��Left=�63   $��274,117,0,0q�6N   $	��Top=�6c   $��65��6{   $��2��6�   
���   �$
��Bold"�6�   �� 55   
   -   5        $ label1��55      $��	Password:��6    $
��Left=�64   $��274,174,0,0q�6O   $	��Top=�6d   $��70��6|   $��2��6�   
���   �$
��Bold"�6�   56      57      