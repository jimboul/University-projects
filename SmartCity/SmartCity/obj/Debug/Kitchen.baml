   M S B A M L   `   `   `  ����D  @SmartCity, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null%clr-namespace:SmartCity	SmartCity  5   	       SmartCity.Kitchen   5   	   \ XPresentationFramework, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35R NWindowsBase, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35W SPresentationCore, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35D 9http://schemas.microsoft.com/winfx/2006/xaml/presentation    5   	   R NSystem.Xaml, Version=4.0.0.0, Culture=neutral, PublicKeyToken=b77a5c561934e089:x,http://schemas.microsoft.com/winfx/2006/xaml     5   	   @d2http://schemas.microsoft.com/expression/blend/2008     5   	   Jmc;http://schemas.openxmlformats.org/markup-compatibility/2006     5   	   )localclr-namespace:SmartCity     5   	     � Title$  Kitchen��5   	   $	��500��6   $	��700��6&   $	��500��62   $	��700��6B    � WindowStartupLocation$ CenterScreen=�6Q    � 	Resources 5	         MyButtonStyle �� 
TargetType �� Property �� Value �� 
TargetType �� Padding �� CornerRadius	 �� Triggers
 P� Property P� Value �� 
TargetName��%  &	        �� 5
   
   " ��6&   .�5      ��  �@�OverridesDefaultStyle . 66   �� 5       � ��$ 5q�6'   �� 5       � �� 5      �� 5      " ��6&   .R�5      �� $��border��6!   $��0q�5      $	 4,2q�5      
�������$ 3��5      #��z��5      ._�5      �� $��Center=�6/   $��Center=�6L   5      	 5      P� 5      
 �@J�IsMouseOver . . �5   "   �� $ border��6)    � ��
 �   �6T   5      5      5      5       5!      .��5"      � ��5#   
   �� 5$       �� ImageSource$ img/kitchen.jpg��6   .+�5&   
   �� -   5         ��Name$
 back��5&      $�� ��6   #��[  6*    � ToolTip$ Go Back��6Q   $
��Left=�6c   $��649,420,0,0q�6~   $	��Top=�6�   $��37��6�   $��43��6�   ��5'      �� 5(      $ img/back.png��6   5*      �� 5+   
   -   5        $ machine��5+      $�� ��6"   #��[  6-   $
��Left=�6T   $��434,194,0,0q�6o   $	��Top=�6�   $��55��6�   $��64��6�   ��5,      �� 5-      $ img/machine.png��6   5/      �� 50   
   -   5        $ package��50      #��[  6"   $ 	Insert Fi��6I   $�� ��6]   $
��Left=�6h   $��658,240,0,0q�6�   $	��Top=�6�   $��34��6�   $��35��6�   ��51      �� 52      $ img/bag.png��6   54      �� 55   
   -   5        $	 jug��55      $�� ��6   #��[  6)   $
��Left=�6P   $��252,204,0,0q�6k   $	��Top=�6�   $��43��6�   $��48��6�   ��56      �� 57      $ img/jug1.png��6   59      r� 5:   
   -   5         r�Name$ player��5:       r� LoadedBehavior$ Manual=�6'   $
��Left=�6?   $	��100��6Z   $��
10,359,0,0q�6g    r� Source$` ZC:\Users\Dimitris\Documents\Visual Studio 2015\Projects\SmartCity\SmartCity\img\csound.mp3?�6{   $	��Top=�6�   $	��100��6�   �� 5;   
   -   5        $	 cup��5;      $�� ��6   #��[  6)   $
��Left=�6P   $��635,270,-2,0q�6k   $	��Top=�6�   $��59��6�   $��33��6�   $y�Hidden=�6�   ��5<      �� 5=      $ img/cup.png��6   5?      r� 5@   
   -   5        $ coffeedrink��5@      $ Manual=�6,   $
��Left=�6D   $	��100��6_   $��
10,254,0,0q�6l   $	��Top=�6�   $	��100��6�   $` ZC:\Users\Dimitris\Documents\Visual Studio 2015\Projects\SmartCity\SmartCity\img\csound.mp3?�6�   �� 5A   
   -   5        $ button2��5A      $�� ��6"    � Cursor$
 Hand��6-   $� �Click the coffee bag on the right hand side on the screen to insert some coffee into your coffee machine. Do not forget that you have to have put the appropriate quantity of water into the machine. To put some water click the jug locating about at the center of the screen. To start the coffee machine just click the machine next the kitchen. Finally, click the cup to drink your coffee. Enjoy it!��6;   $
��Left=�6�  $��
649,10,0,0q�6�  $	��Top=�6  $��33��6  $��32��6%  $��0q�61  ��5B      �� 5C      $ img/help.png��6   5E      5F      5G      