package com.tp.yogioteur.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.tp.yogioteur.domain.MemberDTO;
import com.tp.yogioteur.domain.SignOutMemberDTO;


@Mapper
public interface MemberMapper {
	
	public MemberDTO selectMemberById(String memberId);
	public MemberDTO selectMemberByEmail(String memberEmail);
	public int insertMember(MemberDTO member);
	
	public MemberDTO selectMemberByIdPw(MemberDTO member);
	public int insertMemberLog(String memberId);

	public MemberDTO findMemberByNameEmail(MemberDTO member);
	
	public MemberDTO selectMemberByIdEmail(MemberDTO member);
	public int updatePw(MemberDTO member);
	
	public int removeMember(MemberDTO member);
	public SignOutMemberDTO selectSignOutMemberByMemberId(String memberId);

	public int updateMember(MemberDTO member);
	
	
	public Long selectNaverNo(Map user);
	public Long insertNaverMember(Map user);
	public int insertNaverLog(String id);
	
}
