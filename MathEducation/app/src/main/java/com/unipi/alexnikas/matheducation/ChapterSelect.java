package com.unipi.alexnikas.matheducation;

import android.content.Context;
import android.net.Uri;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageButton;
import android.widget.TextView;
import android.widget.Toast;

import com.google.firebase.database.DataSnapshot;
import com.google.firebase.database.DatabaseError;
import com.google.firebase.database.DatabaseReference;
import com.google.firebase.database.FirebaseDatabase;
import com.google.firebase.database.ValueEventListener;


/**
 * A simple {@link Fragment} subclass.
 * Activities that contain this fragment must implement the
 * {@link ChapterSelect.OnFragmentInteractionListener} interface
 * to handle interaction events.
 * Use the {@link ChapterSelect#newInstance} factory method to
 * create an instance of this fragment.
 */
public class ChapterSelect extends Fragment {
    // TODO: Rename parameter arguments, choose names that match
    // the fragment initialization parameters, e.g. ARG_ITEM_NUMBER
    private static final String ARG_PARAM1 = "param1";
    private static final String ARG_PARAM2 = "param2";

    // TODO: Rename and change types of parameters
    private String mParam1;
    private String mParam2;

    private Button chapter1Btn, chapter2Btn, chapter3Btn;
    private TextView reactionChap1, reactionChap2, reactionChap3;
    private ImageButton imageButton2, imageButton3, imageButton4, imageButton5, imageButton6, imageButton7;
    private String chapterSelected;
    private String username;
    private int chapter1, chapter2, chapter3;

    private ImageButton helpBtnChapSelect;
    private static final String NEUTRAL = "Did you understand this chapter?";
    private static final String POSITIVE = "I understood this chapter!!!";
    private static final String NEGATIVE = "I did not understand this chapter..";
    private OnFragmentInteractionListener mListener;

    public ChapterSelect() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @param param1 Parameter 1.
     * @param param2 Parameter 2.
     * @return A new instance of fragment ChapterSelect.
     */
    // TODO: Rename and change types and number of parameters
    public static ChapterSelect newInstance(String param1, String param2) {
        ChapterSelect fragment = new ChapterSelect();
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
        View view = inflater.inflate(R.layout.fragment_chapter_select, container, false);
        chapter1Btn = (Button) view.findViewById(R.id.chapter1Btn);
        chapter2Btn = (Button) view.findViewById(R.id.chapter2Btn);
        chapter3Btn = (Button) view.findViewById(R.id.chapter3Btn);
        reactionChap1 = (TextView) view.findViewById(R.id.reactionChap1);
        reactionChap2 = (TextView) view.findViewById(R.id.reactionChap2);
        reactionChap3 = (TextView) view.findViewById(R.id.reactionChap3);
        imageButton2 = (ImageButton) view.findViewById(R.id.imageButton2);
        imageButton3 = (ImageButton) view.findViewById(R.id.imageButton3);
        imageButton4 = (ImageButton) view.findViewById(R.id.imageButton4);
        imageButton5 = (ImageButton) view.findViewById(R.id.imageButton5);
        imageButton6 = (ImageButton) view.findViewById(R.id.imageButton6);
        imageButton7 = (ImageButton) view.findViewById(R.id.imageButton7);
        helpBtnChapSelect = (ImageButton) view.findViewById(R.id.helpBtnChapSelect);

        username = getActivity().getIntent().getExtras().getString("username");
        final DatabaseReference rootRef = FirebaseDatabase.getInstance().getReference();
        final DatabaseReference refUpdates = FirebaseDatabase.getInstance().getReference().child("users").child(username).child("statistics");
        rootRef.addListenerForSingleValueEvent(new ValueEventListener() {

            @Override
            public void onDataChange(DataSnapshot snapshot) {
                chapter1 = Integer.parseInt(snapshot.child("users").child(username).child("statistics").child("chapter1").getValue().toString());
                chapter2 = Integer.parseInt(snapshot.child("users").child(username).child("statistics").child("chapter2").getValue().toString());
                chapter3 = Integer.parseInt(snapshot.child("users").child(username).child("statistics").child("chapter3").getValue().toString());
                switch (chapter1){
                    case -1: reactionChap1.setText(NEUTRAL);
                        break;
                    case 0: reactionChap1.setText(NEGATIVE);
                        break;
                    case 1: reactionChap1.setText(POSITIVE);
                        break;
                    default:
                }
                switch (chapter2){
                    case -1: reactionChap2.setText(NEUTRAL);
                        break;
                    case 0: reactionChap2.setText(NEGATIVE);
                        break;
                    case 1: reactionChap2.setText(POSITIVE);
                        break;
                    default:
                }
                switch (chapter3){
                    case -1: reactionChap3.setText(NEUTRAL);
                        break;
                    case 0: reactionChap3.setText(NEGATIVE);
                        break;
                    case 1: reactionChap3.setText(POSITIVE);
                        break;
                    default:
                }
            }
            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });
        chapter1Btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                chapterSelected = "Chapter1";
                ChapterView chapterView = new ChapterView();
                Bundle b = new Bundle();
                b.putString("chapterSelected",chapterSelected); // it may be the opposite pair
                chapterView.setArguments(b);
                FragmentManager fragmentManager = getFragmentManager();
                FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                fragmentTransaction.replace(R.id.fragment_container, chapterView); // or R.layout.fragment_search_result
                fragmentTransaction.commit();
            }
        });
        chapter2Btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                chapterSelected = "Chapter2";
                ChapterView chapterView = new ChapterView();
                Bundle b = new Bundle();
                b.putString("chapterSelected",chapterSelected); // it may be the opposite pair
                chapterView.setArguments(b);
                FragmentManager fragmentManager = getFragmentManager();
                FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                fragmentTransaction.replace(R.id.fragment_container, chapterView); // or R.layout.fragment_search_result
                fragmentTransaction.commit();
            }
        });

        chapter3Btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                chapterSelected = "Chapter3";
                ChapterView chapterView = new ChapterView();
                Bundle b = new Bundle();
                b.putString("chapterSelected",chapterSelected); // it may be the opposite pair
                chapterView.setArguments(b);
                FragmentManager fragmentManager = getFragmentManager();
                FragmentTransaction fragmentTransaction = fragmentManager.beginTransaction();
                fragmentTransaction.replace(R.id.fragment_container, chapterView); // or R.layout.fragment_search_result
                fragmentTransaction.commit();
            }
        });

        imageButton2.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                reactionChap1.setText(NEGATIVE);
                setData("chapter1", 0, refUpdates);
            }
        });

        imageButton3.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                    reactionChap1.setText(POSITIVE);
                setData("chapter1", 1, refUpdates);
            }
        });

        imageButton4.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                reactionChap2.setText(POSITIVE);
                setData("chapter2", 1, refUpdates);
            }
        });

        imageButton5.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                reactionChap3.setText(POSITIVE);
                setData("chapter3", 1, refUpdates);
            }
        });

        imageButton6.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                reactionChap2.setText(NEGATIVE);
                setData("chapter2", 0, refUpdates);
            }
        });
        imageButton7.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                reactionChap3.setText(NEGATIVE);
                setData("chapter3", 0, refUpdates);
            }
        });
        helpBtnChapSelect.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Toast.makeText(getContext(), "Give us a feedback whether you understood the chapter or not.", Toast.LENGTH_SHORT).show();
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

    public void setData(final String chapter, final int value, final DatabaseReference refUpdates){
        refUpdates.addListenerForSingleValueEvent(new ValueEventListener() {
            @Override
            public void onDataChange(DataSnapshot dataSnapshot) {
                //DatabaseReference update = refUpdates.push();
                refUpdates.child(chapter).setValue(value);
            }

            @Override
            public void onCancelled(DatabaseError databaseError) {

            }
        });

    }
}
