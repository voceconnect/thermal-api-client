describe('WisP', function () {

    describe('Post Model', function () {
        beforeEach(function () {
            this.posts = new WisP.Post();
        });
    });

    describe('Posts Collection', function () {
        beforeEach(function () {
            this.posts = new WisP.Posts([], {page: 4});
        });

        it('The posts collection should set the page attribute', function () {
            expect(this.posts.page).toBe(4);
        });
    });

    describe('Post View', function () {
        beforeEach(function () {
            this.posts = new WisP.PostView();
        });
    });

    describe('Post Archive View', function () {
        beforeEach(function () {
            this.posts = new WisP.PostArchiveView();
        });
    });

});