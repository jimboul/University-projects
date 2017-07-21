package com.unipi.alexnikas.matheducation;

import android.content.Context;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.google.android.gms.tasks.OnFailureListener;
import com.google.android.gms.tasks.OnSuccessListener;
import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;
import com.google.firebase.storage.FileDownloadTask;
import com.google.firebase.storage.FirebaseStorage;
import com.google.firebase.storage.StorageReference;

import java.io.File;
import java.io.IOException;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link SearchResult.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link SearchResult#newInstance} factory method to
 * create an instance of this fragment.
 */
public class SearchResult extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    private TextView textView14, textView15, textView16, textView17, statView2, statView3;
    private ImageView imageView2;
    private String name, surname, birthDate, gender;
    private StorageReference mStorageRef;
    private int chap1, chap2, chap3;
    private double total;

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private OnFragmentInteractionListener mListener;

    public SearchResult() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment SearchResult.
     */
    // TODO: Rename and change types and number of parameters
    public static SearchResult newInstance(String param1, String param2) {
        SearchResult fragment = new SearchResult();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_search_result, container, false);

        textView14 = (TextView) view.findViewById(R.id.textView14);
        textView15 = (TextView) view.findViewById(R.id.textView15);
        textView16 = (TextView) view.findViewById(R.id.textView16);
        textView17 = (TextView) view.findViewById(R.id.textView17);
        imageView2 = (ImageView) view.findViewById(R.id.imageView2);
        statView2 = (TextView) view.findViewById(R.id.statView2);
        statView3 = (TextView) view.findViewById(R.id.statView3);
        //System.out.println("!!!!!!!!!!!!!!!!!!!!" + R.id.searchBd + " " + R.id.textView17);

        DatabaseReference rootRef = FirebaseDatabase.getInstance().getReference();
        final String username = this.getArguments().getString("typed_username");
        mStorageRef = FirebaseStorage.getInstance().getReference().child(username + ".jpg");
        rootRef.addValueEventListener(new ValueEventListener() {

            @Override
            public void onDataChange(DataSnapshot snapshot) {
                name = snapshot.child("users").child(username).child("name").getValue().toString();
                surname = snapshot.child("users").child(username).child("surname").getValue().toString();
                birthDate = snapshot.child("users").child(username).child("birthdate").getValue().toString();
                gender = snapshot.child("users").child(username).child("gender").getValue().toString();
                textView14.setText(name);
                textView15.setText(surname);
                textView16.setText(birthDate);
                textView17.setText(gender);
                chap1 = Integer.parseInt(snapshot.child("users").child(username).child("statistics").child("chapter1").getValue().toString());
                chap2 = Integer.parseInt(snapshot.child("users").child(username).child("statistics").child("chapter2").getValue().toString());
                chap3 = Integer.parseInt(snapshot.child("users").child(username).child("statistics").child("chapter3").getValue().toString());
                if (chap1 == -1) chap1 = 0;
                if (chap2 == -1) chap2 = 0;
                if (chap3 == -1) chap3 = 0;
                total = ((double) (chap1 + chap2 + chap3)/3)*100;
                total = Math.round(total*100)/100.0d;
                statView3.setText(String.valueOf(total) + "%");
            }
            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
        try {
            final File localFile = File.createTempFile(username, "jpg");

            mStorageRef.getFile(localFile)
                    .addOnSuccessListener(new OnSuccessListener<FileDownloadTask.TaskSnapshot>() {

                        @Override
                        public void onSuccess(FileDownloadTask.TaskSnapshot taskSnapshot) {
                            // Successfully downloaded data to local file
                            // ...
                            BitmapFactory.Options options = new BitmapFactory.Options();
                            options.inPreferredConfig = Bitmap.Config.ARGB_8888;
                            Bitmap photopath = BitmapFactory.decodeFile(localFile.getAbsolutePath(), options);
                            imageView2.setImageBitmap(photopath);
                        }
                    }).addOnFailureListener(new OnFailureListener() {
                @Override
                public void onFailure(@NonNull Exception exception) {
                    // Handle failed download
                    // ...
                }
            });
        }
        catch (IOException e) {
            e.printStackTrace();
        }
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }


        return view;
        //return inflater.inflate(R.layout.fragment_search_profile, container, false);
    }

    // TODO: Rename method, update argument and hook method into UI event
    public void onButtonPressed(Uri uri) {
        if (mListener != null) {
            mListener.onFragmentInteraction(uri);
        }
    }

    @Override
    public void onAttach(Context context) {
        super.onAttach(context);
        if (context instanceof OnFragmentInteractionListener) {
            mListener = (OnFragmentInteractionListener) context;
        } else {
            throw new RuntimeException(context.toString()
                    + " must implement OnFragmentInteractionListener");
        }
    }

    @Override
    public void onDetach() {
        super.onDetach();
        mListener = null;
    }

    /**
     * This interface must be implemented by activities that contain this
     * fragment to allow an interaction in this fragment to be communicated
     * to the activity and potentially other fragments contained in that
     * activity.
     * <p>
     * See the Android Training lesson <a href=
     * "http://developer.android.com/training/basics/fragments/communicating.html"
     * >Communicating with Other Fragments</a> for more information.
     */
    public interface OnFragmentInteractionListener {
        // TODO: Update argument type and name
        void onFragmentInteraction(Uri uri);
    }
}
