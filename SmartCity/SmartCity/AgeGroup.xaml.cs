using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using System.IO;

namespace SmartCity
{
    /// <summary>
    /// Interaction logic for AgeGroup.xaml
    /// </summary>
    public partial class AgeGroup : Window
    {
        public AgeGroup()
        {
            InitializeComponent();
        }

        string current_path = Environment.GetFolderPath(Environment.SpecialFolder.MyDocuments);

        List<string> requests = null;
        string request1 = null;
        string request2 = null;
        string request3 = null;
        string request4 = null;
        string request5 = null;
        string requestOK = null;

        string other_requests = null;

        private void checkBox2_Checked(object sender, RoutedEventArgs e)
        {
            checkBox1.IsEnabled = false;
            request2 = checkBox2.Content.ToString() + Environment.NewLine;
        }

        private void checkBox3_Checked(object sender, RoutedEventArgs e)
        {
            checkBox1.IsEnabled = false;
            request3 = checkBox3.Content.ToString() + Environment.NewLine;
        }

        private void checkBox4_Checked(object sender, RoutedEventArgs e)
        {
            checkBox1.IsEnabled = false;
            request4 = checkBox4.Content.ToString() + Environment.NewLine;
        }

        private void checkBox5_Checked(object sender, RoutedEventArgs e)
        {
            textBox.IsEnabled = true;
            checkBox1.IsEnabled = false;
            request5 = other_requests + Environment.NewLine;
        }

        private void checkBox_Checked(object sender, RoutedEventArgs e)
        {
            checkBox1.IsEnabled = false;
            request1 = checkBox.Content.ToString() + Environment.NewLine;
        }

        private void checkBox1_Checked(object sender, RoutedEventArgs e)
        {
            checkBox.IsEnabled = false;
            checkBox2.IsEnabled = false;
            checkBox3.IsEnabled = false;
            checkBox4.IsEnabled = false;
            checkBox5.IsEnabled = false;
            requestOK = checkBox1.Content.ToString() + Environment.NewLine;
        }

        private void button_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show("Your request has been sent to the Administration successfully!");
            try
            {
                foreach (string str in requests)
                    File.WriteAllText(current_path + @"\Visual Studio 2015\Projects\SmartCity\SmartCity\requests.txt", str + Environment.NewLine);
            }
            catch (NullReferenceException ex)
            {
                Console.WriteLine("{0} Exception caught.", ex);
            }
        }

        private void textBox_TextChanged(object sender, TextChangedEventArgs e)
        {
            other_requests = textBox.Text;
        }

        private void button1_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show(button1.ToolTip.ToString());
        }

        private void back_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainwindow = new MainWindow();
            mainwindow.Show();
            this.Hide();
            MessageBox.Show("You are logged out!");
        }
    }
}
