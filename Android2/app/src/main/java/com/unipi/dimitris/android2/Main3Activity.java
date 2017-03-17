package com.unipi.dimitris.android2;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.ArrayAdapter;
import android.widget.ListView;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;

public class Main3Activity extends AppCompatActivity {

    String[] keys;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main3);
        final FirebaseDatabase database = FirebaseDatabase.getInstance();
        DatabaseReference ref = database.getReference().child("location");
        ref.addListenerForSingleValueEvent(new ValueEventListener() {

            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                int counter = 0;
                for (DataSnapshot dataSnapshot1 : dataSnapshot.getChildren()) {
                    keys[counter] = dataSnapshot1.getKey() + " " + dataSnapshot1.getValue(String.class);
                    counter++;
                }
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {
                System.out.println("The read failed: " + databaseError.getCode());
            }
        });

        ArrayAdapter adapter = new ArrayAdapter<String>(this,
                R.layout.activity_listview, keys);

        ListView listView = (ListView) findViewById(R.id.list);
        listView.setAdapter(adapter);

    }
}
