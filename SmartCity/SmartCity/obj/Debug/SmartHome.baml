   M S B A M L   `   `   `  ����D  @SmartCity, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null%clr-namespace:SmartCity	SmartCity  5   	       SmartCity.SmartHome   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   )localclr-namespace:SmartCity     5   	     � Title$  	SmartHome��5   	   $	��500��6   $	��700��6)   $	��500��65   $	��700��6E    � WindowStartupLocation$ CenterScreen=�6T    � 	Resources 5	         MyButtonStyle �� 
TargetType �� Property �� Value �� 
TargetType �� Padding �� CornerRadius	 �� Triggers
 P� Property P� Value �� 
TargetName��%  &	        �� 5
   
   " ��6&   .�5      ��  �@�OverridesDefaultStyle . 66   �� 5       � ��$ 5q�6'   �� 5       � �� 5      �� 5      " ��6&   .R�5      �� $��border��6!   $��0q�5      $	 4,2q�5      
�������$ 3��5      #��z��5      ._�5      �� $��Center=�6/   $��Center=�6L   5      	 5      P� 5      
 �@J�IsMouseOver . . �5   "   �� $ border��6)    � ��
 �   �6T   5      5      5      5       5!      .��5"      � ��5#   
   �� 5$       �� ImageSource$ img/home.jpg��6   .+�5&   
   �� -   5         ��Name$ button2��5&      $�� ��6"    � Cursor$
 Hand��6-    � ToolTip$- 'Click the door to go inside your house.��6;   $
��Left=�6m   $��
640,10,0,0q�6�   $	��Top=�6�   $��35��6�   $��33��6�   $��0q�6�   ��5'      �� 5(      $ img/help.png��6   5*      �� 5+   
   -   5        $ button��5+      $�� ��6!   #��[  6,   $ Enter the home��6S   $
��Left=�6l   $��321,288,0,0q�6�   $	��Top=�6�   $��58��6�   $��90��6�   $��0q�6�    J� Opacity$ 0Q�6  $
 Hand��6  ��6�   Z� ��6�   Z� ��5,      �� 5-       �� Opacity$ 0Q�6   5/      �� 50   
   -   5        $
 back��50      $�� ��6   #��[  6*   $ Go Back��6Q   $
��Left=�6c   $��649,420,0,0q�6~   $	��Top=�6�   $��37��6�   $��43��6�   ��51      �� 52      $ img/back.png��6   54      55      56      