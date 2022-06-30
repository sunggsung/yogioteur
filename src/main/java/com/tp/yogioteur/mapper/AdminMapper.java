package com.tp.yogioteur.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.tp.yogioteur.domain.ImageDTO;
import com.tp.yogioteur.domain.MemberDTO;
import com.tp.yogioteur.domain.ReservationDTO;
import com.tp.yogioteur.domain.RoomDTO;

@Mapper
public interface AdminMapper {

	public int insertRoom(RoomDTO room);
	public int insertImage(ImageDTO image);
	
	public List<RoomDTO> selectRoomList(Map<String, Object> map);
	public int selectRoomCount();
	public RoomDTO selectRoomByNo(Long RoomNo);
	public ImageDTO selectImageByNo(Long imageNo);
	
	public List<ImageDTO> selectImageListInTheRoom(Long roomNo);
	public int deleteRoom(Long roomNo);
	
	public int updateRoom(RoomDTO room);
	public int updateImageByNo(ImageDTO image);
	
	public List<MemberDTO> selectMemberList(Map<String, Object> map);
	public int selectMemberCount();
	public MemberDTO selectMemberByNo(Long memberNo);
	
	public List<MemberDTO> selectReservationList(Map<String, Object> map);
	public int selectReservationCount();
	public List<ReservationDTO> selectReservationByMemberNo(Long memberNo);
}
