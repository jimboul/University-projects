package com.unipi.alexnikas.matheducation;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link Badges.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link Badges#newInstance} factory method to
 * create an instance of this fragment.
 */
public class Badges extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";
    private ImageView badgeView, badgeView1;
    private String username;
    private int chapter1, chapter2, chapter3;
    private double score1, score2, score3;

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private OnFragmentInteractionListener mListener;

    public Badges() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment Badges.
     */
    // TODO: Rename and change types and number of parameters
    public static Badges newInstance(String param1, String param2) {
        Badges fragment = new Badges();
        Bundle args = new Bundle();
        args.putString(ARG_PARAM1, param1);
        args.putString(ARG_PARAM2, param2);
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getArguments() != null) {
            mParam1 = getArguments().getString(ARG_PARAM1);
            mParam2 = getArguments().getString(ARG_PARAM2);
        }
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        View view = inflater.inflate(R.layout.fragment_badges, container, false);
        badgeView = (ImageView) view.findViewById(R.id.badgeView);
        badgeView1 = (ImageView) view.findViewById(R.id.badgeView1);
        username = getActivity().getIntent().getExtras().getString("username");
        DatabaseReference rootRef = FirebaseDatabase.getInstance().getReference();

        rootRef.addListenerForSingleValueEvent(new ValueEventListener() {

            @Override
            public void onDataChange(DataSnapshot snapshot) {

                chapter1 = Integer.parseInt(snapshot.child("users").child(username).child("statistics").child("chapter1").getValue().toString());
                chapter2 = Integer.parseInt(snapshot.child("users").child(username).child("statistics").child("chapter2").getValue().toString());
                chapter3 = Integer.parseInt(snapshot.child("users").child(username).child("statistics").child("chapter3").getValue().toString());
                score1 = Double.parseDouble(snapshot.child("users").child(username).child("statistics").child("test1_result").getValue().toString());
                score2 = Double.parseDouble(snapshot.child("users").child(username).child("statistics").child("test2_result").getValue().toString());
                score3 = Double.parseDouble(snapshot.child("users").child(username).child("statistics").child("test3_result").getValue().toString());
                if (chapter1 == 1 && chapter2 == 1 && chapter3 == 1){
                    badgeView1.setImageResource(R.mipmap.badge1);
                }
                if (score1 == 100 && score2 == 100 && score3 == 100){
                    badgeView.setImageResource(R.mipmap.badge);
                }

            }
            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
        return view;
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
