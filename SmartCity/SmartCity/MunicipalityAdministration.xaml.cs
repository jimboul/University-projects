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
using System.Windows.Threading;

namespace SmartCity
{
    /// <summary>
    /// Interaction logic for MunicipalityAdministration.xaml
    /// </summary>
    public partial class MunicipalityAdministration : Window
    {
        public MunicipalityAdministration()
        {
            InitializeComponent();
            webbrowser1.Navigate("http://www.livecameras.gr/");
            DispatcherTimer dispatcherTimer1 = new DispatcherTimer();
            dispatcherTimer1.Tick += new EventHandler(dispatcherTimer1_Tick);
            dispatcherTimer1.Interval = new TimeSpan(0, 0, 10);
            dispatcherTimer1.Start();
        }

        private void dispatcherTimer1_Tick(object sender, EventArgs e)
        {
            try
            {
                List<string> names = new List<string>();
                names.Add("James");
                names.Add("Mary");
                names.Add("Lilly");
                names.Add("Joanna");
                names.Add("John");
                names.Add("Kate");
                names.Add("Thomas");
                names.Add("Liam");
                names.Add("George");
                names.Add("Angelina");
                Random random = new Random();
                int i = random.Next(1, 11);
                MessageBox.Show("Attention please! " + names[i] + " has fallen! A request for help has just been sent! Had not you responsed within 10 seconds we are going to send you help immediately in the context of emergency!");
                names.Clear();
            }
            catch (ArgumentOutOfRangeException ex)
            {
                Console.WriteLine("{0} Exception caught.", ex);
            }
        }

        private void back_Click(object sender, RoutedEventArgs e)
        {
            MainWindow mainwindow = new MainWindow();
            mainwindow.Show();
            this.Hide();
            MessageBox.Show("You are logged out!");
        }

        private void button2_Click(object sender, RoutedEventArgs e)
        {
            MessageBox.Show(button2.ToolTip.ToString());
        }
    }
}
