// 댓글 작성
$('#addComment').click(function () {
    const content = $('#commentContent').val();
    const parentNum = $(this).data('parent');
    const depth = $(this).data('depth');
	const nick = $(this).data('nick');
    $.ajax({
        url: 'comment',
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            nickName: nick,
            content: content,
            parentNum: parentNum,
            depth: depth
        }),
        success: function () {
            location.reload();
        }
    });
});

// 수정 버튼 클릭 시 수정 영역 표시 및 기존 내용 삽입
$(document).on('click', '.editComment', function () {
    const parentDiv = $(this).closest('div'); // 현재 댓글의 div
    const content = parentDiv.find('.commentContent').text(); // 기존 댓글 내용
    const editSection = parentDiv.find('.editSection');

    // 현재 댓글 수정 영역만 표시
    $('.editSection').hide(); // 다른 댓글 수정 영역 숨기기
    $('.commentContent').show(); // 다른 댓글 내용 표시

    editSection.find('.editTextarea').val(content); // textarea에 기존 내용 삽입
    parentDiv.find('.commentContent').hide(); // 현재 댓글 내용 숨김
    editSection.show(); // 현재 댓글 수정 영역 표시
});
// 수정 취소 버튼 클릭
$(document).on('click', '.cancelEdit', function () {
    const parentDiv = $(this).closest('.mb-3'); // 댓글의 div
    parentDiv.find('.commentContent').show(); // 기존 댓글 다시 표시
    parentDiv.find('.editSection').hide(); // 수정 영역 숨김
});

// 수정 저장 버튼 클릭
$(document).on('click', '.saveEdit', function () {
    const commentId = $(this).data('id'); // 댓글 ID
    const newContent = $(this).siblings('.editTextarea').val(); // 수정된 내용

    if (newContent.trim() === '') {
        alert('수정 내용을 입력하세요.');
        return;
    }

    $.ajax({
        url: 'comment', // 서버의 수정 API
        method: 'PUT',
        contentType: 'application/json',
        data: JSON.stringify({
            brdNum: commentId,
            content: newContent
        }),
        success: function () {
            location.reload(); // 수정 완료 후 새로고침
        },
        error: function () {
            alert('댓글 수정 중 오류가 발생했습니다.');
        }
    });
});

// 댓글 삭제
$('.deleteComment').click(function () {
    const commentId = $(this).data('id');
    if (confirm('삭제하시겠습니까?')) {
        $.ajax({
            url: `comment/${commentId}`,
            method: 'DELETE',
            success: function () {
                // 해당 댓글을 삭제된 메시지로 변경
                location.reload(true);
            },
            error: function () {
                alert('댓글 삭제 중 오류가 발생했습니다.');
            }
        });
    }
});


// 답글 버튼 클릭 시 답글 입력 영역 동적 추가
$(document).on('click', '.replyButton', function () {
    const parentDiv = $(this).closest('div'); // 부모 댓글의 div
    const replySection = parentDiv.find('.replySection');

    // 이미 입력 중인 답글이 없을 경우에만 생성
    if (replySection.length === 0) {
        const replyBox = `
            <div class="replySection">
                <textarea class="form-control replyTextarea" placeholder="답글을 입력하세요"></textarea>
                <button class="btn btn-sm btn-primary submitReply" data-parent="${$(this).data('id')}" data-depth="${$(this).data('depth')}">답글 작성</button>
                <button class="btn btn-sm btn-secondary cancelReply">취소</button>
            </div>
        `;
        parentDiv.append(replyBox);
    }
});

// 답글 작성 취소 버튼
$(document).on('click', '.cancelReply', function () {
    $(this).closest('.replySection').remove();
});

// 답글 작성 완료 처리
$(document).on('click', '.submitReply', function () {
    const parentId = $(this).data('parent'); // 부모 댓글 ID
    const depth = $(this).data('depth'); // 답글 계층
    const content = $(this).siblings('.replyTextarea').val(); // 답글 내용
    const nick = $('#addComment').data('nick'); // 사용자 닉네임

    if (content.trim() === '') {
        alert('답글 내용을 입력하세요.');
        return;
    }

    $.ajax({
        url: 'comment', // 서버의 댓글 작성 API
        method: 'POST',
        contentType: 'application/json',
        data: JSON.stringify({
            nickName: nick,
            content: content,
            parentNum: parentId,
            depth: depth
        }),
        success: function () {
            location.reload(); // 답글 작성 후 페이지 새로고침
        },
        error: function () {
            alert('답글 작성 중 오류가 발생했습니다.');
        }
    });
});

var likeBtn = document.querySelector("#likeBtn");
console.log(likeBtn);
if(likeBtn!=null){
	likeBtn.addEventListener('click',addLike)	
}

function addLike(){
	const brdNum = $(this).data('brdnum');
	const nickName = $(this).data('nick');
	console.log("게시글 번호 : " + brdNum);
	console.log("좋아요 누른 유저 닉네임 : " + nickName);
	$.ajax({
		url : 'addLike',
		method : 'post',
		contentType : 'application/json',
		data : JSON.stringify({
			brdNum : brdNum,
			nickName : nickName
		}),
		success: function () {
		    location.reload(); // 답글 작성 후 페이지 새로고침
        },
        error: function () {
            alert('답글 작성 중 오류가 발생했습니다.');
        }	
	});
}

var cancelBtn = document.querySelector("#cancelBtn")
console.log(cancelBtn);
if(cancelBtn!=null){
	cancelBtn.addEventListener('click', cancelLike);
}

function cancelLike(){
	const brdNum = $(this).data('brdnum');
	const nickName = $(this).data('nick');
	console.log("게시글 번호 : " + brdNum);
	console.log("좋아요 취소한 유저 닉네임 : " + nickName);
	$.ajax({
		url : 'cancelLike',
		method : 'post',
		contentType : 'application/json',
		data : JSON.stringify({
			brdNum : brdNum,
			nickName : nickName
		}),
		success: function () {
            location.reload(); // 답글 작성 후 페이지 새로고침
        },
        error: function () {
            alert('답글 작성 중 오류가 발생했습니다.');
        }
	});
}


/*이미지 띄우기 */
document.getElementById('imageUpload').addEventListener('change', function (event) {
    const file = event.target.files[0];
    const preview = document.getElementById('previewImage');
    const textarea = document.getElementById('content');

    if (file) {
        const reader = new FileReader();

        // 파일 읽기 완료 후 실행
        reader.onload = function (e) {
            // 미리보기 이미지 표시
            preview.src = e.target.result;
            preview.style.display = 'block';

            // 텍스트에 이미지 삽입 버튼 추가
            const insertButton = document.createElement('button');
            insertButton.textContent = "텍스트에 이미지 삽입";
            insertButton.style.marginTop = '10px';
            preview.parentElement.appendChild(insertButton);

            // 버튼 클릭 시 텍스트에 이미지 태그 삽입
            insertButton.addEventListener('click', function () {
                const imgTag = `<img src="${e.target.result}" style="max-width: 300px;" />`;
                textarea.value += `\n${imgTag}\n`;
            });
        };

        reader.readAsDataURL(file); // 파일을 Base64 URL로 읽기
    } else {
        preview.style.display = 'none';
    }
});


