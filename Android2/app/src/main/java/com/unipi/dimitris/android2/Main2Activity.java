package com.unipi.dimitris.android2;


import android.content.Context;
import android.content.Intent;
import android.content.pm.PackageManager;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

import java.text.DateFormat;
import java.util.Date;


public class Main2Activity extends AppCompatActivity implements LocationListener {
    String[] parts;
    int radius;
    float distance;
    Location gpsLocation, poiLocation;
    String place, key, entranceTimestamp;
    TextView textView2;
    boolean flag = true;
    final FirebaseDatabase database = FirebaseDatabase.getInstance();
    DatabaseReference ref = database.getReference().child("location");
    boolean crazy_moment = false;
    Intent intent;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main2);

        LocationManager locationManager = (LocationManager) getSystemService(Context.LOCATION_SERVICE);
        gpsLocation = new Location("");
        poiLocation = new Location("");
        textView2 = (TextView) findViewById(R.id.textView2);
        if (ActivityCompat.checkSelfPermission(this, android.Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{android.Manifest.permission.ACCESS_FINE_LOCATION}, 9);
        }
        locationManager.requestLocationUpdates(LocationManager.GPS_PROVIDER, 0, 0, this);
        intent = new Intent(this, Main3Activity.class);
    }


    @Override
    public void onLocationChanged(Location location) {
        gpsLocation.setLatitude(location.getLatitude());
        gpsLocation.setLongitude(location.getLongitude());
        final FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference ref = database.getReference().child("location");
        ref.addListenerForSingleValueEvent(new ValueEventListener() {

            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                if(flag == true) {
                    getData(dataSnapshot);
                    //flag = false;
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                System.out.println("The read failed: " + databaseError.getCode());
            }
        });
    }

    @Override
    public void onStatusChanged(String s, int i, Bundle bundle) {

    }

    @Override
    public void onProviderEnabled(String s) {

    }

    @Override
    public void onProviderDisabled(String s) {

    }

    public boolean checkLocation() {
        distance = poiLocation.distanceTo(gpsLocation);
        //Toast.makeText(getApplicationContext(), "la = " + parts[0] + " lo = " + parts[1] + " gla = " + gpsLocation.getLatitude() + " glo = " + gpsLocation.getLongitude(), Toast.LENGTH_LONG).show();
        //Toast.makeText(getApplicationContext(), "radius = " + radius + " distance = " + distance, Toast.LENGTH_LONG).show();
        boolean check = (radius > distance);
        //Toast.makeText(getApplicationContext(), radius + "\n" + distance + "\n" + check, Toast.LENGTH_SHORT).show();
        if (radius <= distance) {
            if ((textView2.getText().equals("No data")) || (textView2.getText().equals("Not close to any point of interest"))) {
                textView2.setText("Not close to any point of interest");
            }
            else if (textView2.getText().toString().toLowerCase().contains("You are inside ".toLowerCase())){
                textView2.setText("Not close to any point of interest");
                //exitTimestamp(entranceTimestamp, null); //θέλω να συνεχιστεί το loop χωρίς να τυπωθεί τίποτα ούτε στο textview ούτε στη firebase.
            }
            else Toast.makeText(getApplicationContext(), "Something went wrong", Toast.LENGTH_SHORT).show();
        }
        else {
            boolean check1 = textView2.getText().equals("No data");
            boolean check2 = textView2.getText().equals("Not close to any point of interest");
            //boolean check3 = check1||check2;
            //Toast.makeText(getApplicationContext(), "check1: " + check1 + " check2: " + check2 + " check3: " + check3 , Toast.LENGTH_LONG).show();
            if (check1 || check2) {
                textView2.setText("You are inside " + key);
                entranceTimestamp();
            }
            else if (textView2.getText().toString().equals("You are inside " + key)){
                return true;
            }
            else if (textView2.getText().toString().toLowerCase().contains("You are inside ".toLowerCase())){
                if ((!(textView2.getText().toString().substring(15).equals(key)))) {
                    crazy_moment = true;
                    entranceTimestamp();
                    Toast.makeText(getApplicationContext(), textView2.getText().toString().substring(15), Toast.LENGTH_LONG).show();
                    exitTimestamp(entranceTimestamp, textView2.getText().toString().substring(15));
                    crazy_moment = false;
                    textView2.setText("You are inside " + key);
                }
                else
                    Toast.makeText(getApplicationContext(), "tha trekseis epitelous???", Toast.LENGTH_LONG).show();
            }
            return true;
        }
        return false;
    }

    public void getData(DataSnapshot dataSnapshot) {

        for (DataSnapshot dataSnapshot1 : dataSnapshot.getChildren()) {
            key = dataSnapshot1.getKey();
            place = dataSnapshot1.getValue(String.class);
            parts = place.split("; ");
            poiLocation.setLatitude(Double.parseDouble(parts[0]));
            poiLocation.setLongitude(Double.parseDouble(parts[1]));
            radius = Integer.parseInt(parts[2]);
            checkLocation();
            if (checkLocation())
                break;
//            else
//                checkLocation();
        }
    }

    public void entranceTimestamp() {

        flag = false;
        String curr_timestamp = DateFormat.getDateTimeInstance().format(new Date());
        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference referenceCoordinates = database.getReference("timestamp");
        entranceTimestamp = "Entrance: " + curr_timestamp;
        //Toast.makeText(getApplicationContext(), key , Toast.LENGTH_SHORT).show();
        referenceCoordinates.child(key).setValue(entranceTimestamp);
        flag = true;

    }

    public void exitTimestamp(String value, String optional) {

        flag = false;
        String curr_timestamp = DateFormat.getDateTimeInstance().format(new Date());
        FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference referenceCoordinates = database.getReference("timestamp");
        Toast.makeText(getApplicationContext(), "προηγούμενο " + optional + " τωρινό " + key, Toast.LENGTH_LONG).show();
        if (crazy_moment)
            referenceCoordinates.child(optional).setValue("crazy " + value + " Exit :" + curr_timestamp);
        else
            referenceCoordinates.child(key).setValue(value + " Exit :" + curr_timestamp);
        //Toast.makeText(getApplicationContext(), key , Toast.LENGTH_SHORT).show();
        flag = true;
    }

    public void goToThirdActivity(View view) {
        startActivity(intent);
    }
}